//
//  SendViewController.m
//  CityGuide
//
//  Created by Taras on 6/25/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "SendMessageViewController.h"
#import <MessageUI/MessageUI.h>

static NSString *URL_MAIL = @"vdvdomodedovo@yandex.ru";

@interface SendMessageViewController ()<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextView *textMain;

@end

@implementation SendMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Сообщение";
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKey)];
    [self.view addGestureRecognizer:singleFingerTap];
}

-(BOOL)cheсkLine{
    if (self.name.text.length == 0){
        [AppManager showMessage:@"Не заполнено поле имя"];
        return NO;
    }else if (self.phone.text.length == 0){
        [AppManager showMessage:@"Не заполнено поле телефон"];
        return NO;
    }else if (self.textMain.text.length == 0){
        [AppManager showMessage:@"Не заполнено поле текст сообщения"];
        return NO;
    }
    
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}

-(void)hideKey{
    [self.name resignFirstResponder];
    [self.phone resignFirstResponder];
    [self.textMain resignFirstResponder];
}

- (IBAction)send:(id)sender {
    if (self.cheсkLine) {
        NSString *messageBody = [NSString stringWithFormat:@"Имя: %@\n Телефон: %@\n Сообщение: %@",self.name.text,self.phone.text,self.textMain.text];
        
        NSArray *toRecipents = [NSArray arrayWithObject:URL_MAIL];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:@"Сообщение"];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        [self presentViewController:mc animated:YES completion:NULL];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
