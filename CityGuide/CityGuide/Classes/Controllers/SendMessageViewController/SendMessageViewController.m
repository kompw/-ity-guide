//
//  SendViewController.m
//  CityGuide
//
//  Created by Taras on 6/25/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "SendMessageViewController.h"

@interface SendMessageViewController ()
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
        
    }
}



@end
