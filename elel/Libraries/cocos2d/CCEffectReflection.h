//
//  CCEffectReflection.h
//  cocos2d-ios
//
//  Created by Thayer J Andrews on 7/14/14.
//
//

#import "CCEffect.h"


/**
 * CCEffectReflection uses reflection to simulate the appearance of a shiny object contained within 
 * an environment. Reflection is controlled with two fresnel reflectance values, the normal map, and 
 * a reflection environment sprite.
 *
 */
@interface CCEffectReflection : CCEffect

/// -----------------------------------------------------------------------
/// @name Creating a Reflection Effect
/// -----------------------------------------------------------------------

/**
*  Creates a CCEffectReflection object with the specified environment and the following default parameters:
*  fresnelBias = 1.0, fresnelPower = 0.0, normalMap = nil
*
*  @param shininess The overall shininess of the effect.
*  @param environment The environment image that will be reflected by the affected node.
*
*  @return The CCEffectReflection object.
*  @since v3.2 and later
*  @see CCSprite
*/
+(instancetype)effectWithShininess:(float)shininess environment:(CCSprite *)environment;

/**
 *  Creates a CCEffectReflection object with the specified environment and normal map and the following default parameters:
*  fresnelBias = 1.0, fresnelPower = 0.0
*
*  @param shininess The overall shininess of the effect.
 *  @param environment The environment image that will be reflected by the affected node.
 *  @param normalMap The normal map of the affected node. This can also be specified as a property of the affected sprite.
 *
 *  @return The CCEffectReflection object.
 *  @since v3.2 and later
 *  @see CCSprite
 *  @see CCSpriteFrame
 */
+(instancetype)effectWithShininess:(float)shininess environment:(CCSprite *)environment normalMap:(CCSpriteFrame *)normalMap;

/**
 *  Creates a CCEffectReflection object with the specified parameters and nil normal map.
 *
 *  @param shininess The overall shininess of the effect.
 *  @param bias The bias term in the fresnel reflectance equation.
 *  @param power The power term in the fresnel reflectance equation.
 *  @param environment The environment image that will be reflected by the affected node.
 *
 *  @return The CCEffectReflection object.
 *  @since v3.2 and later
 *  @see CCSprite
 */
+(instancetype)effectWithShininess:(float)shininess fresnelBias:(float)bias fresnelPower:(float)power environment:(CCSprite *)environment;

/**
 *  Creates a CCEffectReflection object with the specified parameters.
 *
 *  @param shininess The overall shininess of the effect.
 *  @param bias The bias term in the fresnel reflectance equation.
 *  @param power The power term in the fresnel reflectance equation.
 *  @param environment The environment image that will be reflected by the affected node.
 *  @param normalMap The normal map of the affected node. This can also be specified as a property of the affected sprite.
 *
 *  @return The CCEffectReflection object.
 *  @since v3.2 and later
 *  @see CCSprite
 *  @see CCSpriteFrame
 */
+(instancetype)effectWithShininess:(float)shininess fresnelBias:(float)bias fresnelPower:(float)power environment:(CCSprite *)environment normalMap:(CCSpriteFrame *)normalMap;


/**
 *  Initializes a CCEffectReflection object with the following default parameters:
 *  fresnelBias = 1.0, fresnelPower = 0.0, environment = nil, normalMap = nil
 *
 *  @return The CCEffectReflection object.
 *  @since v3.2 and later
 */
-(id)init;

/**
 *  Initializes a CCEffectReflection object with the specified environment and normal map and the following default parameters:
 *  fresnelBias = 1.0, fresnelPower = 0.0, normalMap = nil
 *
 *  @param shininess The overall shininess of the effect.
 *  @param environment The environment image that will be reflected by the affected node.
 *
 *  @return The CCEffectReflection object.
 *  @since v3.2 and later
 *  @see CCSprite
 */
-(id)initWithShininess:(float)shininess environment:(CCSprite *)environment;

/**
 *  Initializes a CCEffectReflection object with the specified environment and normal map and the following default parameters:
 *  fresnelBias = 1.0, fresnelPower = 0.0
 *
 *  @param shininess The overall shininess of the effect.
 *  @param environment The environment image that will be reflected by the affected node.
 *  @param normalMap The normal map of the affected node. This can also be specified as a property of the affected sprite.
 *
 *  @return The CCEffectReflection object.
 *  @since v3.2 and later
 *  @see CCSprite
 *  @see CCSpriteFrame
 */
-(id)initWithShininess:(float)shininess environment:(CCSprite *)environment normalMap:(CCSpriteFrame *)normalMap;

/**
 *  Initializes a CCEffectReflection object with the specified parameters and a nil normal map.
 *
 *  @param shininess The overall shininess of the effect.
 *  @param bias The bias term in the fresnel reflectance equation.
 *  @param power The power term in the fresnel reflectance equation.
 *  @param environment The environment image that will be reflected by the affected node.
 *
 *  @return The CCEffectReflection object.
 *  @since v3.2 and later
 *  @see CCSprite
 */
-(id)initWithShininess:(float)shininess fresnelBias:(float)bias fresnelPower:(float)power environment:(CCSprite *)environment;

/**
 *  Initializes a CCEffectReflection object with the specified parameters.
 *
 *  @param shininess The overall shininess of the effect.
 *  @param bias The bias term in the fresnel reflectance equation.
 *  @param power The power term in the fresnel reflectance equation.
 *  @param environment The environment image that will be reflected by the affected node.
 *  @param normalMap The normal map of the affected node. This can also be specified as a property of the affected sprite.
 *
 *  @return The CCEffectReflection object.
 *  @since v3.2 and later
 *  @see CCSprite
 *  @see CCSpriteFrame
 */
-(id)initWithShininess:(float)shininess fresnelBias:(float)bias fresnelPower:(float)power environment:(CCSprite *)environment normalMap:(CCSpriteFrame *)normalMap;


/// -----------------------------------------------------------------------
/// @name Reflection Properties
/// -----------------------------------------------------------------------

/** The overall shininess of the attached sprite. This value is in the range [0..1] and it controls
 *  how much of the reflected environment contributes to the final color of the affected pixels.
 *  @since v3.2 and later
 */
@property (nonatomic, assign) float shininess;

/** The bias term in the fresnel reflectance equation:
 *    reflectance = max(0.0, fresnelBias + (1 - fresnelBias) * pow((1 - nDotV), fresnelPower))
 *  This value is in the range [0..1] and it controls the constant (view angle independent) contribution
 *  to the reflectance equation.
 *  @since v3.2 and later
 */
@property (nonatomic, assign) float fresnelBias;

/** The power term in the fresnel reflectance equation:
 *    reflectance = max(0.0, fresnelBias + (1 - fresnelBias) * pow((1 - nDotV), fresnelPower))
 *  This value is in the range [0..inf] and it controls the view angle dependent contribution
 *  to the reflectance equation.
 *  @since v3.2 and later
 */
@property (nonatomic, assign) float fresnelPower;

/// -----------------------------------------------------------------------
/// @name Environment and Normal Map
/// -----------------------------------------------------------------------

/** The environment that will be reflected by the affected node. Typically this is a sprite
 *  that is not visible in the scene as it is conceptually "behind the viewer" and only visible
 *  where reflected by the affected node.
 *  @since v3.2 and later
 *  @see CCSprite
 */
@property (nonatomic, strong) CCSprite *environment;

/** The normal map that encodes the normal vectors of the affected node. Each pixel in the normal
 *  map is a 3 component vector that is perpendicular to the surface of the sprite at that point.
 *  @since v3.2 and later
 *  @see CCSpriteFrame
 */
@property (nonatomic, strong) CCSpriteFrame *normalMap;


@end
