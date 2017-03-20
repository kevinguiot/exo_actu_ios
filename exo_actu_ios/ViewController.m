//
//  ViewController.m
//  exo_actu_ios
//
//  Created by GUIOT Kevin on 20/03/2017.
//  Copyright © 2017 GUIOT Kevin. All rights reserved.
//

#import "ViewController.h"
#import "XMLReader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *testXMLString = @"<items><item id=\"0001\" type=\"donut\"><name>Cake</name><ppu>0.55</ppu><batters><batter id=\"1001\">Regular</batter><batter id=\"1002\">Chocolate</batter><batter id=\"1003\">Blueberry</batter></batters><topping id=\"5001\">None</topping><topping id=\"5002\">Glazed</topping><topping id=\"5005\">Sugar</topping></item></items>";
    // Parse the XML into a dictionary
    NSError *parseError = nil;
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:testXMLString error:&parseError];
    
    // Print the dictionary
    NSLog(@"%@", xmlDictionary);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
