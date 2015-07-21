//
//  OrderController.m
//  CityGuide
//
//  Created by Taras on 7/21/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "OrderController.h"
#import <MessageUI/MessageUI.h>

@interface OrderController ()<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *adress;

@end

@implementation OrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Заказ доставки";
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
    }else if (self.adress.text.length == 0){
        [AppManager showMessage:@"Не заполнено поле текст адрес"];
        return NO;
    }
    
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)hideKey{
    [self.name resignFirstResponder];
    [self.phone resignFirstResponder];
    [self.adress resignFirstResponder];
}

- (IBAction)sendMail:(id)sender {
    if (self.cheсkLine) {
        self.messageBody = [NSString stringWithFormat:@"Имя: %@\n Телефон: %@\n Адрес: %@\n %@ ",self.name.text,self.phone.text,self.adress.text,self.messageBody];
        
        NSArray *toRecipents = [NSArray arrayWithObject:self.email];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:@"Заказ"];
        [mc setMessageBody:self.messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        [self presentViewController:mc animated:YES completion:NULL];
    }
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
