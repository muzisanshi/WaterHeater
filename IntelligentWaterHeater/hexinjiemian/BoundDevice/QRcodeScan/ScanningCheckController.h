//
//  ScanningCheckController.h
//  Essentials
//
//  Created by mac on 15/6/24.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ScanningCheckController : UIViewController
/**
 * 登录人姓名
 */
@property (nonatomic, copy) NSString * name;

/**
 * 项目id
 */
@property (nonatomic, copy) NSNumber * projectID ;

/**
 * 岗位id
 */
@property (nonatomic, copy) NSNumber * positonID ;

/**
 * 0 上班 1 下班
 */
@property (nonatomic, assign) int inOrOut;

@end
