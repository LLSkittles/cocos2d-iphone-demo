//
//  CCEffectContrast.m
//  cocos2d-ios
//
//  Created by Thayer J Andrews on 5/7/14.
//
//

#import "CCEffectContrast.h"
#import "CCEffect_Private.h"
#import "CCRenderer.h"
#import "CCTexture.h"

static float conditionContrast(float contrast);

@interface CCEffectContrast ()
@property (nonatomic, strong) NSNumber *conditionedContrast;
@end


@interface CCEffectContrastImpl : CCEffectImpl
@property (nonatomic, weak) CCEffectContrast *interface;
@end


@implementation CCEffectContrastImpl

-(id)initWithInterface:(CCEffectContrast *)interface
{
    CCEffectUniform* uniformContrast = [CCEffectUniform uniform:@"float" name:@"u_contrast" value:[NSNumber numberWithFloat:1.0f]];
    
    NSArray *fragFunctions = [CCEffectContrastImpl buildFragmentFunctions];
    NSArray *renderPasses = [CCEffectContrastImpl buildRenderPassesWithInterface:interface];

    if((self = [super initWithRenderPasses:renderPasses fragmentFunctions:fragFunctions vertexFunctions:nil fragmentUniforms:@[uniformContrast] vertexUniforms:nil varyings:nil]))
    {
        self.interface = interface;
        self.debugName = @"CCEffectContrastImpl";
    }
    return self;
}

+ (NSArray *)buildFragmentFunctions
{
    CCEffectFunctionInput *input = [[CCEffectFunctionInput alloc] initWithType:@"vec4" name:@"inputValue" initialSnippet:CCEffectDefaultInitialInputSnippet snippet:CCEffectDefaultInputSnippet];

    NSString* effectBody = CC_GLSL(
                                   vec3 offset = vec3(0.5) * inputValue.a;
                                   return vec4(((inputValue.rgb - offset) * vec3(u_contrast) + offset), inputValue.a);
                                   );
    
    CCEffectFunction* fragmentFunction = [[CCEffectFunction alloc] initWithName:@"contrastEffect" body:effectBody inputs:@[input] returnType:@"vec4"];
    return @[fragmentFunction];
}

+ (NSArray *)buildRenderPassesWithInterface:(CCEffectContrast *)interface
{
    __weak CCEffectContrast *weakInterface = interface;
    
    CCEffectRenderPass *pass0 = [[CCEffectRenderPass alloc] init];
    pass0.debugLabel = @"CCEffectContrast pass 0";
    pass0.beginBlocks = @[[[CCEffectRenderPassBeginBlockContext alloc] initWithBlock:^(CCEffectRenderPass *pass, CCEffectRenderPassInputs *passInputs){
        
        passInputs.shaderUniforms[CCShaderUniformMainTexture] = passInputs.previousPassTexture;
        passInputs.shaderUniforms[CCShaderUniformPreviousPassTexture] = passInputs.previousPassTexture;
        passInputs.shaderUniforms[CCShaderUniformTexCoord1Center] = [NSValue valueWithGLKVector2:passInputs.texCoord1Center];
        passInputs.shaderUniforms[CCShaderUniformTexCoord1Extents] = [NSValue valueWithGLKVector2:passInputs.texCoord1Extents];

        passInputs.shaderUniforms[passInputs.uniformTranslationTable[@"u_contrast"]] = weakInterface.conditionedContrast;
    }]];
    
    return @[pass0];
}

@end


@implementation CCEffectContrast

-(id)init
{
    return [self initWithContrast:0.0f];
}

-(id)initWithContrast:(float)contrast
{
    if((self = [super init]))
    {
        _contrast = contrast;
        _conditionedContrast = [NSNumber numberWithFloat:conditionContrast(contrast)];

        self.effectImpl = [[CCEffectContrastImpl alloc] initWithInterface:self];
        self.debugName = @"CCEffectContrast";
    }
    return self;
}

+(instancetype)effectWithContrast:(float)contrast
{
    return [[self alloc] initWithContrast:contrast];
}

-(void)setContrast:(float)contrast
{
    _contrast = contrast;
    _conditionedContrast = [NSNumber numberWithFloat:conditionContrast(contrast)];
}

@end


float conditionContrast(float contrast)
{
    NSCAssert((contrast >= -1.0) && (contrast <= 1.0), @"Supplied contrast out of range [-1..1].");

    // Yes, this value is somewhat magical. It was arrived at experimentally by comparing
    // our results at min and max contrast (-1 and 1 respectively) with the results from
    // various image editing applications at their own min and max contrast values.
    static const float kContrastBase = 4.0f;
    
    float clampedExp = clampf(contrast, -1.0f, 1.0f);
    return powf(kContrastBase, clampedExp);
}
