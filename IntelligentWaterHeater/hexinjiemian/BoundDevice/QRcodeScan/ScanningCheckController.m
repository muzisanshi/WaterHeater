//
//  ScanningCheckController.m
//  Essentials
//
//  Created by mac on 15/6/24.
//
//

#import "ScanningCheckController.h"
#import "QRView.h"
@interface ScanningCheckController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate,XPGWifiSDKDelegate,XPGWifiDeviceDelegate> {
    
    UILabel *label;
    AVCaptureDeviceInput *input;
    AVCaptureVideoPreviewLayer *preview;
    AVCaptureSession *session;
    
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    
    
    
}

@property (nonatomic, strong) UIImageView * line;

@property (nonatomic ,strong) UIView *scanView;
@property (nonatomic ,strong) UIButton *button;
@property (nonatomic ) AVCaptureSession *captureSession; //二维码生成绘画
@property (nonatomic) AVCaptureVideoPreviewLayer *previewLayer; //二维码生成图层
@property (nonatomic) BOOL lastResut;




@end

@implementation ScanningCheckController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Qr Code Scanning";
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[leftBtn alloc] initWithFrame:CGRectMake(0, 0, 44, 44)]];
    //配置二维码扫描
    [self configurationScan];
    [XPGWifiSDK sharedInstance].delegate = self;

}
- (void)configurationScan {
    
    self.view.backgroundColor = [UIColor grayColor];
    //    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
    //    scanButton.frame = CGRectMake(100, 420, 120, 40);
    //    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:scanButton];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(30, 50, mScreen.width - 60, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.font = [UIFont systemFontOfSize:15];
    labIntroudction.text=@"Align QR code with in frame to scan";
    [self.view addSubview:labIntroudction];
    
    
//    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, mScreen.width - 100, 220)];
//    imageView.image = [UIImage imageNamed:@"code.png"];
//    [self.view addSubview:imageView];
    
//    UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mScreen.width, mScreen.height- 64)];
//    background.image = [UIImage imageNamed:@"Candidate-二维码"];
//    [self.view addSubview:background];
    
    //QRVIEW
    CGRect screenRect = CGRectMake(0, 0, mScreen.width, mScreen.height- 64);
    QRView *qrRectView = [[QRView alloc] initWithFrame:screenRect];
    qrRectView.transparentArea = CGSizeMake(200, 200);
    qrRectView.backgroundColor = [UIColor clearColor];
//    qrRectView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [self.view addSubview:qrRectView];

    
    upOrdown = NO;
    num =0;
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((mScreen.width - 220)/2, 110 , 220, 1)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    
    //
    //    label = [[UILabel alloc]init];
    //    label.layer.borderColor = [[UIColor blueColor]CGColor];
    //    label.layer.borderWidth = 1.0;
    //    label.frame = CGRectMake( 8, 100, [UIScreen mainScreen].bounds.size.width - 16, 30);
    //    [self.view addSubview:label];
    
    //获取摄像头
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //设置输入
    NSError *error = nil;
    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if (error) {
       [[ [UIAlertView alloc]initWithTitle:nil message:@"No camera" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        NSLog(@"没有摄像头");
        return;
    }
    
    //设置输出
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //    [output setRectOfInterest:CGRectMake(0.2, 0.2, 0.2, 0.2)];
    //拍摄会话
    session = [[AVCaptureSession alloc]init];
    [session addInput:input];
    [session addOutput:output];
    
    //设置输出格式
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    //设置预览图层
    preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    
    //设置preview图层的属性
    [preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    //设置preview图层的大小
    [preview setFrame:CGRectMake(0, 0 , mScreen.width , mScreen.height)];
//    ((mScreen.width - 220)/2, 110, 220, 220)
    [output setRectOfInterest:CGRectMake(110/mScreen.height, ((mScreen.width - 220)/2)/mScreen.width, 220/mScreen.height, 220/mScreen.width)];
    
    
    //将图层添加到视图的图层
    [self.view.layer insertSublayer:preview atIndex:0];
    self.previewLayer = preview;
    
    //启动会话
    [session startRunning];
    
    self.captureSession = session;
    
}

-(void)animation1
{
    
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake((mScreen.width - 220)/2, 110+2*num, 220, 2);
        if (2*num == 200) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake((mScreen.width - 220)/2, 110+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
    
}

- (void)scan {
    
    _line.hidden = NO;
    [session startRunning];
    
    self.captureSession = session;
    
    
}

- (void)btnClick {
    
    [self scan];
}
#pragma mark -<>

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    _line.hidden = YES;
    //如果扫描完成，停止会话
    [self.captureSession stopRunning];
    
    //删除预览图层
    //    [self.previewLayer removeFromSuperlayer];
    
    AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];

    NSLog(@"11 == %@",  [obj.stringValue componentsSeparatedByString:@"="]);
    
    //设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        NSLog(@"11 == %@",  obj.stringValue);
    //提示：如果需要对url或者名片等信息进行扫描，可在此进行拓展
        
        NSString * productkey;
        NSString * did;
        NSArray * array = [obj.stringValue componentsSeparatedByString:@"="];
        if (array.count >=4) {
                productkey  = [array[1] substringToIndex:((NSString *)array[1]).length -4];
                did = [array[2] substringToIndex:((NSString *)array[2]).length -9];
            [XPGWifiSDK updateDeviceFromServer:productkey];
            NSLog(@"已安装了设备的配置文件，可以进行设备控制了");

            [[XPGWifiSDK sharedInstance] bindDeviceWithUid:[Userinfo currentUser].uid token:[Userinfo currentUser].token did:did passCode:array[3] remark:nil];
            
        }
  
    }
}

- (void)XPGWifiSDK:(XPGWifiSDK *)wifiSDK didBindDevice:(NSString *)did error:(NSNumber *)error errorMessage:(NSString *)errorMessage{
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    
}
- (void)XPGWifiSDK:(XPGWifiSDK *)wifiSDK didUpdateProduct:(NSString *)product result:(int)result;
{
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (buttonIndex == 1){
        [session startRunning];
        _line.hidden = NO;

    }
}

@end
