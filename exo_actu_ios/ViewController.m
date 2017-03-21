//
//  ViewController.m
//  exo_actu_ios
//
//  Created by GUIOT Kevin on 20/03/2017.
//  Copyright © 2017 GUIOT Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "XMLReader.h"

struct Item
{
    __unsafe_unretained NSString *link;
    __unsafe_unretained NSString *title;
    __unsafe_unretained NSString *description;
    __unsafe_unretained NSString *pubDate;
};

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Récupération du contenu XML des actus le monde
    NSURL *urlActu = [NSURL URLWithString:@"http://www.lemonde.fr/rss/une.xml"];
    NSError* error;
    NSString *actuXML = [NSString stringWithContentsOfURL:urlActu encoding:NSASCIIStringEncoding error:&error];
    
    // Parse du contenu dans un dictionnaire
    NSError *parseError = nil;
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:actuXML error:&parseError];
    
    // Récupération des items
    NSDictionary *items = xmlDictionary[@"rss"][@"channel"][@"item"];

    // On parcourt les items
    for (NSDictionary* item in items) {
        
        // On récupère la description de l'item
        NSDictionary *description = item[@"description"][@"text"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
