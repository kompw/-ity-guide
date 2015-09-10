//
//  SendNewPosterViewController.m
//  CityGuide
//
//  Created by Taras on 9/9/15.
//  Copyright (c) 2015 t. All rights reserved.
//

#import "SendNewPosterViewController.h"
#import "ActionSheetPicker.h"

typedef enum : NSUInteger {
    CategoryType = 1,
    SubcategoryType = 2
} Type;

@interface SendNewPosterViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *bView;

@property (weak, nonatomic) IBOutlet UITextField *titlePoster;
@property (weak, nonatomic) IBOutlet UITextField *fistName;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *cost;
@property (weak, nonatomic) IBOutlet UITextView *text;

@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIButton *subcategoryButton;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;

@property (nonatomic,strong) NSData *image;
@property (nonatomic,strong) NSString *category_id;
@property (nonatomic,strong) NSString *subcategory_id;

@property (strong, nonatomic) UIImagePickerController * picker;
@end

@implementation SendNewPosterViewController{
    NSArray *categoryData;
    NSArray *subcategoryData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.scroll addGestureRecognizer: tapRec];
    [self.bView addGestureRecognizer: tapRec];
}

-(void)tap:(UITapGestureRecognizer *)tapRec{
    [[self view] endEditing: YES];
}

-(BOOL)isGooDline{
    if (self.titlePoster.text.length == 0) {
        [AppManager showMessage:@"Не заполнено поле Название"];
         return NO;
    }else if (self.fistName.text.length == 0) {
        [AppManager showMessage:@"Не заполнено поле Ваше имя"];
        return NO;
    }else if (self.phone.text.length == 0) {
        [AppManager showMessage:@"Не заполнено поле Телефон для связи"];
        return NO;
    }else if (self.cost.text.length == 0) {
        [AppManager showMessage:@"Не заполнено поле Цена"];
        return NO;
    }else if (self.text.text.length == 0) {
        [AppManager showMessage:@"Не заполнено поле Текст сообщения"];
        return NO;
    }else if (self.subcategory_id.length == 0) {
        [AppManager showMessage:@"Не выбрана подкатегория"];
        return NO;
    }else if (self.image == nil) {
        [AppManager showMessage:@"Не выбрано фото"];
        return NO;
    }
    
    return YES;
}

- (IBAction)category:(id)sender {
    if (categoryData) {
        [self openListWithArray:categoryData sender:sender andType:CategoryType];
    }else
        [ServerManager poster1Data:^(NSArray *array) {
            categoryData = array;
             [self openListWithArray:categoryData sender:sender andType:CategoryType];
        }];
}

- (IBAction)subcategory:(id)sender {
    if (subcategoryData) {
         [self openListWithArray:subcategoryData sender:sender andType:SubcategoryType];
    }else if (self.category_id){
        [ServerManager poster2Data:self.category_id completion:^(NSArray *array) {
            subcategoryData = array;
            [self openListWithArray:subcategoryData sender:sender andType:SubcategoryType];
        }];
    }else
        [AppManager showMessage:@"Выберите вначале категорию"];
}

-(void)openListWithArray:(NSArray*)data sender:(id)sender andType:(Type)type{
    NSMutableArray *titles = [NSMutableArray new];
    for (NSDictionary *dic in data) {
        [titles addObject:dic[name_key]];
    }
    NSString *titleTextPicker = @"";
    switch (type) {
        case CategoryType:
            titleTextPicker= @"Выберите категорию";
            break;
        case SubcategoryType:
            titleTextPicker= @"Выберите подкатегорию";
            break;
        default:
            break;
    }
    [ActionSheetStringPicker showPickerWithTitle:titleTextPicker rows:titles initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [((UIButton*)sender) setTitle:selectedValue forState:UIControlStateNormal];
        NSDictionary *dic = data[selectedIndex];
        
        switch (type) {
            case CategoryType:
                self.category_id = [dic[id_key] description];
                break;
            case SubcategoryType:
                self.subcategory_id = [dic[id_key] description];
                break;
            default:
                break;
        }
    }
    cancelBlock:^(ActionSheetStringPicker *picker) {
    }
    origin:sender];
}


- (IBAction)photo:(id)sender {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (!self.picker) {
            self.picker = [[UIImagePickerController alloc] init];
        }
        
        self.picker.delegate = self;
        self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:self.picker animated:YES completion:nil];
    }];

}

#pragma mark - ImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.image = UIImagePNGRepresentation(originalImage);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendToServer:(id)sender {
    if (![self isGooDline]) {
        return;
    }
    
    NSDictionary *dic = @{
                          name_key : self.titlePoster.text,
                          author_key : self.fistName.text,
                          description_key : self.text.text,
                          price_key : self.cost.text,
                          phone_key : self.phone.text
                          };
    [ServerManager sendNewPosterWithSubcategory:self.subcategory_id andImage:self.image andParameters:dic];
}

#pragma UITextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
