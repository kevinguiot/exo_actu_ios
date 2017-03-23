//
//  ActuTableViewController.m
//  exo_actu_ios
//
//  Created by GUIOT Kevin on 21/03/2017.
//  Copyright © 2017 GUIOT Kevin. All rights reserved.
//

#import "XMLReader.h"
#import "ActuTableViewController.h"
#import "ActuTableViewCell.h"
#import "ItemSelectedViewController.h"

@implementation ActuTableViewController : UITableViewController

NSArray *itemsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Récupération du contenu XML des actus le monde
    NSURL *urlActu = [NSURL URLWithString:@"http://www.lemonde.fr/rss/une.xml"];
    NSError* error;
    NSString *actuXML = [NSString stringWithContentsOfURL:urlActu encoding:NSASCIIStringEncoding error:&error];
    
    // Parse du contenu dans un dictionnaire
    NSError *parseError = nil;
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:actuXML error:&parseError];
    
    // On récupère les items dans un tableau
    itemsArray = xmlDictionary[@"rss"][@"channel"][@"item"];
}

- (void)viewWillAppear:(BOOL)animated {
    
    // On mets à jour la navigation
    self.navigationController.navigationBar.topItem.title = @"Actualité à la Une";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // On renvoit le nombre d'articles
    return itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // On récupère la cellule (avec les outlets)
    ActuTableViewCell *cell = (ActuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"item"];
    
    // On récupère l'item sélectionné
    NSDictionary *item =  itemsArray[indexPath.row];
    
    // On récupère l'URL de l'image
    NSString* urlImage = item[@"enclosure"][@"url"];
    
    // On récupère les informations en décodant l'UTF-8
    NSString *title = [NSString stringWithCString:[item[@"title"][@"text"] cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
    
    NSString *description = [NSString stringWithCString:[item[@"description"][@"text"] cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
    
    // On ouvere un nouveau thread
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        // On récupère le contenu de l'image
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: urlImage]];
        
        if ( data == nil ) return;
        
        // On mets à jour les valeurs de la vue
        dispatch_async(dispatch_get_main_queue(), ^{

            cell.image.image = [UIImage imageWithData: data];
            cell.title.text = title;
            cell.description.text = description;
        });
    });
    
    return cell;
}

// Sélection d'une cellule
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // On récupère l'item sélectionné
    NSDictionary *item =  itemsArray[indexPath.row];
    
    // On récupère l'URL de l'image
    NSString* urlImage = item[@"enclosure"][@"url"];
    
    // On récupère les informations en décodant l'UTF-8
    NSString *title = [NSString stringWithCString:[item[@"title"][@"text"] cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
    
    NSString *description = [NSString stringWithCString:[item[@"description"][@"text"] cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
    
    // On récupère la date
    NSString *dateString = item[@"pubDate"][@"text"];
    
    // On prépare le NSDateFormatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    [formatter setDateFormat:@"E, d MMM yyyy HH:mm:ss Z"];
  
    // On parse la date sous format NSDate
    NSDate *dateParse = [formatter dateFromString:dateString];
    
    // On mets à jour le formatter
    [formatter setDateFormat:@"dd/MM/yyyy à HH:mm:ss"];
    
    // On récupère la nouvelle date en format string
    NSString *date = [formatter stringFromDate:dateParse];

    // On améliore la date
    date = [NSString stringWithFormat:@"Publié le %@", date];
    
    // On créé la vue basée sur la vue existante itemSelected
    ItemSelectedViewController *itemSelected = [self.storyboard instantiateViewControllerWithIdentifier:@"itemSelected"];
        
    // On ouvere un nouveau thread
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        // On récupère le contenu de l'image
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: urlImage]];
        
        if ( data == nil ) return;
        
        // On mets à jour les valeurs de la vue
        dispatch_async(dispatch_get_main_queue(), ^{
            
            itemSelected.title.text = title;
            itemSelected.date.text = date;
            itemSelected.description.text = [NSString stringWithFormat:@"\t%@", description];
            itemSelected.image.image = [UIImage imageWithData: data];
        });
    });
        
    // On se redirige sur la vue
    [self.navigationController pushViewController:itemSelected animated:true];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/@end
