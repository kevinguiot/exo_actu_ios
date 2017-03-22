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
    
    // On mets à jour le titre de la cellule
    cell.title.text = item[@"title"][@"text"];
    
    // On mets à jour la description de la cellule
    cell.description.text = item[@"description"][@"text"];
    
    // On récupère l'URL de l'image
    NSString* urlImage = item[@"enclosure"][@"url"];
    
    // On mets à jour l'image de la cellule de manière asynchrone
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: urlImage]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            cell.image.image = [UIImage imageWithData: data];
        });
    });
    
    return cell;
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
*/

@end
