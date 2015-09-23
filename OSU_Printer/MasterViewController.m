//
//  MasterViewController.m
//  OSU_Printer
//
//  Created by Jinjin Shao on 8/2/15.
//  Copyright (c) 2015 Shao158. All rights reserved.
//

#import "MasterViewController.h"
#import "NMSSH.h"

@interface MasterViewController ()

@property (strong, nonatomic) NSTextField *userNameLabel;
@property (strong, nonatomic) NSTextField *passwordLabel;
@property (strong, nonatomic) NSTextField *userName;
@property (strong, nonatomic) NSSecureTextField *password;
@property (strong, nonatomic) NSTextField *comment;
@property (strong, nonatomic) NSURL *fileURL;
@property (strong, nonatomic) NSTextField *fileLabel;
@property (strong, nonatomic) NSTextField *moreInfo;
@property (strong, nonatomic) NSPopUpButton *printerOptions;
@property (strong, nonatomic) NSPopUpButton *departmentOption;
@property (strong, nonatomic) NSString *serverName;
@property (strong, nonatomic) NSTextField *copies;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    

    self.userNameLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 330, 150, 25)];
    
    [self.userNameLabel setStringValue: @"Your account name: "];
    [self.userNameLabel setBezeled:NO];
    [self.userNameLabel setDrawsBackground:NO];
    [self.userNameLabel setEditable:NO];
    [self.userNameLabel setSelectable:NO];
    [self.userNameLabel setAlignment:NSRightTextAlignment];
    
    [self.view addSubview:self.userNameLabel];
    
    
    self.passwordLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 300, 150, 25)];
    
    [self.passwordLabel setStringValue: @"Password: "];
    [self.passwordLabel setBezeled:NO];
    [self.passwordLabel setDrawsBackground:NO];
    [self.passwordLabel setEditable:NO];
    [self.passwordLabel setSelectable:NO];
    [self.passwordLabel setAlignment:NSRightTextAlignment];
    
    [self.view addSubview:self.passwordLabel];
    
    
    self.userName = [[NSTextField alloc] initWithFrame:NSMakeRect(170, 330, 150, 25)];
    
    [self.userName setStringValue: @""];
    [self.userName setBezeled:YES];
    [self.userName setDrawsBackground:NO];
    [self.userName setEditable:YES];
    [self.userName setSelectable:YES];
    [self.userName setAlignment:NSLeftTextAlignment];
    
    [self.view addSubview:self.userName];
    
    
    self.password = [[NSSecureTextField alloc] initWithFrame:NSMakeRect(170, 300, 150, 25)];
    
    [self.password setStringValue: @""];
    [self.password setBezeled:YES];
    [self.password setDrawsBackground:NO];
    [self.password setEditable:YES];
    [self.password setSelectable:YES];
    [self.password setAlignment:NSLeftTextAlignment];
    
    [self.view addSubview:self.password];
    
    self.departmentOption = [[NSPopUpButton alloc] initWithFrame:NSMakeRect(50, 270, 275, 25)];
    [self.departmentOption addItemWithTitle:@"Which department you are in?"];
    [self.departmentOption addItemWithTitle:@"Computer Science and Engineering"];
    [self.departmentOption addItemWithTitle:@"Electrical and Computer Engineering"];
    
    [self.view addSubview: self.departmentOption];
    
    self.fileLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(50, 200, 270, 50)];
    
    [self.fileLabel setStringValue: @"No File is chosen"];
    [self.fileLabel setBezeled:YES];
    [self.fileLabel setDrawsBackground:NO];
    [self.fileLabel setEditable:NO];
    [self.fileLabel setSelectable:NO];
    [self.fileLabel setAlignment:NSCenterTextAlignment];
    
    [self.view addSubview:self.fileLabel];
    
    
    NSButton *connectButton = [[NSButton alloc] initWithFrame:NSMakeRect(340, 290, 105, 60)];
    
    [connectButton setTitle:@"Connect"];
    [connectButton setButtonType: NSMomentaryPushInButton];
    [connectButton setTarget:self];
    [connectButton setAction:@selector(prepareConnect)];
    
    [self.view addSubview:connectButton];
    
    NSButton *chooseFileButton = [[NSButton alloc] initWithFrame:NSMakeRect(340, 200, 105, 60)];
    
    [chooseFileButton setTitle:@"Choose Files"];
    [chooseFileButton setButtonType:NSMomentaryLightButton];
    [chooseFileButton setTarget:self];
    [chooseFileButton setAction:@selector(getFilePath)];
    
    [self.view addSubview:chooseFileButton];
    
    NSButton *printFileButton = [[NSButton alloc] initWithFrame:NSMakeRect(340, 110, 105, 60)];
    
    [printFileButton setTitle:@"Print Files"];
    [printFileButton setButtonType:NSMomentaryLightButton];
    [printFileButton setTarget:self];
    [printFileButton setAction:@selector(printMyFile)];
    
    [self.view addSubview:printFileButton];
    
    NSTextField *copiesLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(80, 140, 170, 25)];
    
    [copiesLabel setStringValue:@"How many copies printed?"];
    [copiesLabel setBezeled:NO];
    [copiesLabel setDrawsBackground:NO];
    [copiesLabel setEditable:NO];
    [copiesLabel setSelectable:NO];
    
    [self.view addSubview:copiesLabel];
    
    self.copies = [[NSTextField alloc] initWithFrame:NSMakeRect(265, 140, 30, 25)];
    
    [self.copies setStringValue:@"1"];
    [self.copies setBezeled:YES];
    [self.copies setDrawsBackground:NO];
    [self.copies setEditable:YES];
    [self.copies setSelectable:YES];
    
    [self.view addSubview:self.copies];
    
    self.printerOptions = [[NSPopUpButton alloc] initWithFrame:NSMakeRect(50, 105, 275, 35)];
    [self.printerOptions addItemWithTitle:@"Choose Your Printer"];
    
    [self.view addSubview: self.printerOptions];
    
    self.comment = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 10, 430, 70)];
    
    [self.comment setStringValue: @""];
    [self.comment setBezeled:YES];
    [self.comment setDrawsBackground:NO];
    [self.comment setEditable:NO];
    [self.comment setSelectable:NO];
    
    [self.view addSubview:self.comment];
    
    NSTextField *instructionLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(460, 10, 120, 400)];
    
    [instructionLabel setStringValue: @"Print\nin\nJust Three Steps\n\nStep 1:\nInput Your department account\nand password\nthen Connect\n\nStep 2:\nChoose printed files. Now only .pdf, .doc, .docx, .txt can be printed!\n\nStep 3:\nChoose which printer to use, and print your file."];
    [instructionLabel setBezeled:NO];
    [instructionLabel setDrawsBackground:NO];
    [instructionLabel setEditable:NO];
    [instructionLabel setSelectable:NO];
    [instructionLabel setAlignment:NSCenterTextAlignment];
    
    [self.view addSubview:instructionLabel];
}

- (void)prepareConnect {
    NSLog(@"Connect Button is pressed! ");
    
    if ([self.departmentOption.selectedItem.title isEqualToString:@"Computer Science and Engineering"]) {
        self.serverName = @"sl5.cse.ohio-state.edu";
    }else if ([self.departmentOption.selectedItem.title isEqualToString:@"Electrical and Computer Engineering"]) {
        self.serverName = @"rh026.ece.ohio-state.edu";
    }else{
        NSAlert *myAlert = [[NSAlert alloc] init];
        [myAlert setMessageText:@"Pleeeeeeeease Choose your department. If your cannot find your department, contact us!"];
        [myAlert addButtonWithTitle:@"OoooooK."];
        [myAlert runModal];
        
        return;
    }
    
    if([[self.userName stringValue] isEqualToString:@""] || [[self.password stringValue] isEqualToString:@""]) {
        NSAlert *myAlert = [[NSAlert alloc] init];
        [myAlert setMessageText:@"Please input account name and password! "];
        [myAlert addButtonWithTitle:@"Shut up! I know this! "];
        [myAlert runModal];
        
        return;
    }
    
    NMSSHSession *session = [NMSSHSession connectToHost:self.serverName withUsername:[self.userName stringValue]];
    
    if(session.isConnected){
        [session authenticateByPassword:[self.password stringValue]];
        
        if(session.isAuthorized){
            NSAlert *myAlert = [[NSAlert alloc] init];
            [myAlert setMessageText:@"Connected Successfully"];
            [myAlert addButtonWithTitle:@"Yeah !"];
            [myAlert runModal];
            
        }else{
            NSAlert *myAlert = [[NSAlert alloc] init];
            [myAlert setMessageText:@"Sorry, Your Password is wrong! "];
            [myAlert addButtonWithTitle:@"Ok"];
            [myAlert runModal];
            
            return;
        }
    }else{
        NSAlert *myAlert = [[NSAlert alloc] init];
        [myAlert setMessageText:@"Sorry, account doesn't exist! "];
        [myAlert addButtonWithTitle:@"Shut up! I know this! "];
        [myAlert runModal];
        
        return;
    }
    
    NSError *error = nil;
    
    if ([self.departmentOption.selectedItem.title isEqualToString:@"Electrical and Computer Engineering"]) {
        NSString *response = [session.channel execute:@"lpstat -p -d | grep idle | grep 'CL\\|DL' | cut -d' ' -f2" error:&error];
        
        NSArray *printers = [response componentsSeparatedByString:@"\n"];
        
        [self.printerOptions removeAllItems];
        [self.printerOptions addItemWithTitle:@"Choose Your Printer"];
        for(NSString *mystring in printers) {
            NSRange temp1 = [mystring rangeOfString:@"paystation" options:NSCaseInsensitiveSearch];
            NSRange temp2 = [mystring rangeOfString:@"dl" options:NSCaseInsensitiveSearch];
            NSRange temp3 = [mystring rangeOfString:@"cl" options:NSCaseInsensitiveSearch];
            
            if(temp1.location == NSNotFound && (temp2.location == 0 || temp3.location == 0)) {
                [self.printerOptions addItemWithTitle:mystring];
            }
        }
    }else if([self.departmentOption.selectedItem.title isEqualToString:@"Computer Science and Engineering"]) {
        NSString *response = [session.channel execute:@"lpstat -p -d | grep idle | grep 'cl\\|j_dl_' | cut -d' ' -f2" error:&error];
        
        NSArray *printers = [response componentsSeparatedByString:@"\n"];
        
        [self.printerOptions removeAllItems];
        [self.printerOptions addItemWithTitle:@"Choose Your Printer"];
        for(NSString *mystring in printers) {
            NSRange temp = [mystring rangeOfString:@"lj" options:NSCaseInsensitiveSearch];
            if(temp.location == 0) {
                [self.printerOptions addItemWithTitle:mystring];
            }
        }
    }
    
    [session disconnect];
}

- (void)getFilePath {
    NSLog(@"Choosing files! ");
    
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    
    [panel beginWithCompletionHandler:^(NSInteger result){
        if(result == NSFileHandlingPanelOKButton){
            self.fileURL = [panel URL];
            [self.fileLabel setStringValue:[[[[self.fileURL absoluteString] substringFromIndex:7] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] lastPathComponent]];
        }
    }];
    
}

- (void)printMyFile {
    NSLog(@"Printing files! ");
    
    if ([self.printerOptions.selectedItem.title isEqualToString:@"Choose Your Printer"]) {
        NSAlert *printerChooseAlert = [[NSAlert alloc] init];
        [printerChooseAlert setMessageText:@"Buckeye! Please choose your printer before printing any thing!"];
        [printerChooseAlert addButtonWithTitle:@"Shut up! I know this! "];
        [printerChooseAlert runModal];
        
        return;
    }
    
    NSString *myFileName = [[self.fileLabel.stringValue lastPathComponent] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    NSString *connectResult;
    
    NMSSHSession *session = [NMSSHSession connectToHost:self.serverName withUsername:[self.userName stringValue]];
    
    if(session.isConnected){
        [session authenticateByPassword:[self.password stringValue]];
        
        if(session.isAuthorized){
            connectResult = @"Connected Successfully!";
            
        }else{
            NSAlert *myAlert = [[NSAlert alloc] init];
            [myAlert setMessageText:@"Sorry, Your Password is wrong! "];
            [myAlert addButtonWithTitle:@"Ok"];
            [myAlert runModal];
            
            return;
        }
    }else{
        NSAlert *myAlert = [[NSAlert alloc] init];
        [myAlert setMessageText:@"Sorry, account doesn't exist! "];
        [myAlert addButtonWithTitle:@"Shut up! I know this! "];
        [myAlert runModal];
        
        return;
    }
    
    [self.comment setStringValue:connectResult];
    
    NSError *error = nil;
    NSString *response = [session.channel execute:@"cd ;" error:&error];
    
    response = [NSString stringWithFormat:@"Checking root directory..."];
    [self.comment setStringValue: [NSString stringWithFormat:@"%@\n%@", response, self.comment.stringValue] ];
    
    response = [session.channel execute:@"[ ! -d temp_print ] && mkdir temp_print ;" error:&error];
    [self.comment setStringValue: [NSString stringWithFormat:@"%@\n%@", response, self.comment.stringValue] ];
    
    BOOL success = [session.channel uploadFile: [[[self.fileURL absoluteString] substringFromIndex:7] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] to:[NSString stringWithFormat: @"temp_print/%@", myFileName]];
    
    if( [[myFileName substringFromIndex:myFileName.length - 4] isEqualToString:@".doc"]
       || [[myFileName substringFromIndex:myFileName.length - 5] isEqualToString:@".docx"]) {
        if([self.departmentOption.selectedItem.title isEqualToString:@"Electrical and Computer Engineering"]) {
            NSAlert *printerChooseAlert = [[NSAlert alloc] init];
            [printerChooseAlert setMessageText:@"Sorry! For now, printing .doc and .docx is not allowed for ECE account."];
            [printerChooseAlert addButtonWithTitle:@"Ok, I switch to a CSE account or transfer my file to .pdf "];
            [printerChooseAlert runModal];
            
            return;
        }
        NSString *newFileName = [[myFileName stringByDeletingPathExtension] stringByAppendingString: @".pdf"];
        response = [session.channel execute:[NSString stringWithFormat: @"soffice --headless --convert-to pdf temp_print/%@ ; mv %@ temp_print/%@", myFileName, newFileName, newFileName] error:&error];
        myFileName = newFileName;
    }
    
    if(success) {
        response = [NSString stringWithFormat:@"Upload successfully! "];
        [self.comment setStringValue: [NSString stringWithFormat:@"%@\n%@", response, self.comment.stringValue] ];
    }else{
        response = [NSString stringWithFormat:@"Upload failed! "];
        [self.comment setStringValue: [NSString stringWithFormat:@"%@\n%@", response, self.comment.stringValue] ];
    }
    
    NSString *command = [NSString stringWithFormat:@"lp -d %@ -n %@ temp_print/%@", self.printerOptions.selectedItem.title, self.copies.stringValue, myFileName];
    
    response = [session.channel execute:command error:&error];
    
    [self.comment setStringValue: [NSString stringWithFormat:@"%@\n%@", response, self.comment.stringValue] ];
    
    [session disconnect];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender{
    return true;
}

@end
