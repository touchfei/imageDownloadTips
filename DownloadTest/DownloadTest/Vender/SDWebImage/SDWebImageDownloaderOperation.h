/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "SDWebImageDownloader.h"
#import "SDWebImageOperation.h"
/**
 
 
 */
// SDWebImageDownloaderOperation 会发送四种情况通知(开始、接收到数据响应、暂停、完成)
/**
 (1) extern 表明该变量在别的地方已经定义过了,在这里要使用那个变量.
 (2) static 表示静态的变量，分配内存的时候, 存储在静态区,不存储在栈上面
*/
extern NSString * _Nonnull const SDWebImageDownloadStartNotification;
extern NSString * _Nonnull const SDWebImageDownloadReceiveResponseNotification;
extern NSString * _Nonnull const SDWebImageDownloadStopNotification;
extern NSString * _Nonnull const SDWebImageDownloadFinishNotification;



/**
 Describes a downloader operation. If one wants to use a custom downloader op, it needs to inherit from `NSOperation` and conform to this protocol
 */
// 如果我们想要实现一个自定义的下载操作，就必须继承自NSOperation,同时实现SDWebImageDownloaderOperationInterface这个协议
@protocol SDWebImageDownloaderOperationInterface<NSObject>



// 使用NSURLRequest,NSURLSession和SDWebImageDownloaderOptions初始化
- (nonnull instancetype)initWithRequest:(nullable NSURLRequest *)request
                              inSession:(nullable NSURLSession *)session
                                options:(SDWebImageDownloaderOptions)options;
// 为每一个NSOperation自由的添加相应对象
- (nullable id)addHandlersForProgress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                            completed:(nullable SDWebImageDownloaderCompletedBlock)completedBlock;

// 设置是否需要解压图片
- (BOOL)shouldDecompressImages;
- (void)setShouldDecompressImages:(BOOL)value;

// 设置是否需要设置凭证
- (nullable NSURLCredential *)credential;
- (void)setCredential:(nullable NSURLCredential *)value;

@end


@interface SDWebImageDownloaderOperation : NSOperation <SDWebImageDownloaderOperationInterface, SDWebImageOperation, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

/** 
 1.遵守<SDWebImageDownloaderOperationInterface>协议后，该协议的那些方法，都必须实现
 2.getter and setter 方法可以通过属性来实现
 3.通过初始化方法中传入的参数来初始化某一些属性时，该属性在.h文件中往往以只读属性的方式返回
 */

/**
 * The request used by the operation's task.
 */
@property (strong, nonatomic, readonly, nullable) NSURLRequest *request;

/**
 * The operation's task
 */
@property (strong, nonatomic, readonly, nullable) NSURLSessionTask *dataTask;


@property (assign, nonatomic) BOOL shouldDecompressImages;

/**
 *  Was used to determine whether the URL connection should consult the credential storage for authenticating the connection.
 *  @deprecated Not used for a couple of versions
 */
@property (nonatomic, assign) BOOL shouldUseCredentialStorage __deprecated_msg("Property deprecated. Does nothing. Kept only for backwards compatibility");

/**
 * The credential used for authentication challenges in `-connection:didReceiveAuthenticationChallenge:`.
 *
 * This will be overridden by any shared credentials that exist for the username or password of the request URL, if present.
 */

//通过声明一个属性，就实现了SDWebImageDownloaderOperationInterface协议中的 NSURLCredential 的getter 和setter方法
@property (nonatomic, strong, nullable) NSURLCredential *credential;

/**
 * The SDWebImageDownloaderOptions for the receiver.
 */
@property (assign, nonatomic, readonly) SDWebImageDownloaderOptions options;

/**
 * The expected size of data.
 */
@property (assign, nonatomic) NSInteger expectedSize;

/**
 * The response returned by the operation's connection.
 */
@property (strong, nonatomic, nullable) NSURLResponse *response;

/**
 *  Initializes a `SDWebImageDownloaderOperation` object
 *
 *  @see SDWebImageDownloaderOperation
 *
 *  @param request        the URL request
 *  @param session        the URL session in which this operation will run
 *  @param options        downloader options
 *
 *  @return the initialized instance
 */
- (nonnull instancetype)initWithRequest:(nullable NSURLRequest *)request
                              inSession:(nullable NSURLSession *)session
                                options:(SDWebImageDownloaderOptions)options NS_DESIGNATED_INITIALIZER;

/**
 *  Adds handlers for progress and completion. Returns a tokent that can be passed to -cancel: to cancel this set of
 *  callbacks.
 *
 *  @param progressBlock  the block executed when a new chunk of data arrives.
 *                        @note the progress block is executed on a background queue
 *  @param completedBlock the block executed when the download is done.
 *                        @note the completed block is executed on the main queue for success. If errors are found, there is a chance the block will be executed on a background queue
 *
 *  @return the token to use to cancel this set of handlers
 */
- (nullable id)addHandlersForProgress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                            completed:(nullable SDWebImageDownloaderCompletedBlock)completedBlock;

/**
 *  Cancels a set of callbacks. Once all callbacks are canceled, the operation is cancelled.
 *
 *  @param token the token representing a set of callbacks to cancel
 *
 *  @return YES if the operation was stopped because this was the last token to be canceled. NO otherwise.
 */
// 该方法不是取消任务的，而是取消任务中的响应，当时当任务中没有响应者的时候，任务也会被取消
- (BOOL)cancel:(nullable id)token;

@end
