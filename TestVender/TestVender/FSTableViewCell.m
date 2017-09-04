//
//  FSTableViewCell.m
//  TestVender
//
//  Created by gaofei on 2017/8/21.
//



#import "FSTableViewCell.h"
#import "UIImageView+WebCache.h"


@interface FSTableViewCell()
@property (nonatomic, strong)UIImageView *imgView;
@end



@implementation FSTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier   ]) {
        [self initView];
    }
    return self;
}
    

- (void)initView {
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    self.imgView = imageView;
    
}

    
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imgView.frame = self.contentView.bounds;
}

- (void)setUrlStr:(NSString *)urlStr {
    _urlStr = urlStr;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
}
    
    
    
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
