/*
 * cocos2d for iPhone: http://www.cocos2d-iphone.org
 *
 * Copyright (c) 2013-2014 Cocos2D Authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#import "ccMacros.h"

#if __CC_PLATFORM_IOS
#import <UIKit/UIKit.h>									// Needed for UIAccelerometerDelegate
#elif __CC_PLATFORM_MAC

#endif

#import "CCProtocols.h"
#import "CCNode.h"

#pragma mark - CCNodeColor

/**
 Draws a rectangle filled with a solid color.
 */
@interface CCNodeColor : CCNode <CCShaderProtocol, CCBlendProtocol>

/// -----------------------------------------------------------------------
/// @name Creating a Color Node
/// -----------------------------------------------------------------------

/**
 *  Creates a node with color, width and height in Points.
 *
 *  @param color Color of the node.
 *  @param w     Width of the node.
 *  @param h     Height of the node.
 *
 *  @return The CCNodeColor Object.
 *  @see CCColor
 */
+(instancetype) nodeWithColor: (CCColor*)color width:(GLfloat)w height:(GLfloat)h;

/**
 *  Creates a node with color. Width and height are the window size.
 *
 *  @param color Color of the node.
 *
 *  @return The CCNodeColor Object.
 *  @see CCColor
 */
+(instancetype) nodeWithColor: (CCColor*)color;

/**
 *  Creates a node with color, width and height in Points.
 *
 *  @param color Color of the node.
 *  @param w     Width of the node.
 *  @param h     Height of the node.
 *
 *  @return An initialized CCNodeColor Object.
 *  @see CCColor
 */
-(id) initWithColor:(CCColor*)color width:(GLfloat)w height:(GLfloat)h;

/**
 *  Creates a node with color. Width and height are the window size.
 *
 *  @param color Color of the node.
 *
 *  @return An initialized CCNodeColor Object.
 *  @see CCColor
 */
-(id) initWithColor:(CCColor*)color;

@end

#pragma mark - CCNodeGradient

/** 
 Draws a rectangle filled with a gradient.
 
 The gradient node adds the following properties to the ones already provided by CCNodeColor:
 
 - vector (direction)
 - startColor and endColor (gradient colors)
 
 If no vector is supplied, it defaults to (0, -1) - fading from top to bottom. 
 Color is interpolated between the startColor and endColor along the given vector (starting at the origin, ending at the terminus).
 */
@interface CCNodeGradient : CCNodeColor {
	ccColor4F _endColor;
	CGPoint _vector;
}


/// -----------------------------------------------------------------------
/// @name Creating a Gradient Node
/// -----------------------------------------------------------------------

/**
 *  Creates a full-screen CCNode with a gradient between start and end color values.
 *
 *  @param start Start color.
 *  @param end   End color.
 *
 *  @return The CCNodeGradient Object.
 *  @see CCColor
 */
+(instancetype)nodeWithColor:(CCColor*)start fadingTo:(CCColor*)end;

/**
 *  Creates a full-screen CCNode with a gradient between start and end color values with gradient direction vector.
 *
 *  @param start Start color.
 *  @param end   End color.
 *  @param v Direction vector for gradient.
 *
 *  @return The CCNodeGradient Object.
 *  @see CCColor
 */
+(instancetype)nodeWithColor:(CCColor*)start fadingTo:(CCColor*)end alongVector:(CGPoint)v;

/**
 *  Creates a full-screen CCNode with a gradient between start and end color values.
 *
 *  @param start Start color.
 *  @param end   End color.
 *
 *  @return An initialized CCNodeGradient Object.
 *  @see CCColor
 */
- (id)initWithColor:(CCColor*)start fadingTo:(CCColor*)end;

/**
 *  Creates a full-screen CCNode with a gradient between start and end color values with gradient direction vector.
 *
 *  @param start Start color.
 *  @param end   End color.
 *  @param v Direction vector for gradient.
 *
 *  @return An initialized CCNodeGradient Object.
 *  @see CCColor
 */
- (id)initWithColor:(CCColor*)start fadingTo:(CCColor*)end alongVector:(CGPoint)v;


/// -----------------------------------------------------------------------
/// @name Gradient Color and Opacity
/// -----------------------------------------------------------------------

/** The starting color.
 @see CCColor
*/
@property (nonatomic, strong) CCColor* startColor;

/** The ending color. 
 @see CCColor
*/
@property (nonatomic, strong) CCColor* endColor;

/** The start color's opacity. */
@property (nonatomic, readwrite) CGFloat startOpacity;

/** The end color's opacity. */
@property (nonatomic, readwrite) CGFloat endOpacity;

/// -----------------------------------------------------------------------
/// @name Gradient Direction
/// -----------------------------------------------------------------------

/** The vector that determines the gradient's direction. Defaults to {0, -1}. */
@property (nonatomic, readwrite) CGPoint vector;

// purposefully undocumented: property marked as deprecated
/*
 Deprecated in 3.1. All colors are correctly displayed across the node's rectangle.
 Default: YES.

 If compressedInterpolation is disabled, you will not see either the start or end color for non-cardinal vectors.
 A smooth gradient implying both end points will be still be drawn, however.
 
 If compressedInterpolation is enabled (default mode) you will see both the start and end colors of the gradient.
 */
@property (nonatomic, readwrite) BOOL compressedInterpolation __attribute__((deprecated));

@end

#pragma mark - CCNodeMultiplexer

/// -----------------------------------------------------------------------
// purposefully undocumented: the usefulness of this node is questionable
/// -----------------------------------------------------------------------

/* A node which has only one of its children "active". It does so by adding only the active node to its children array,
 the other nodes are stored in a private array until needed.

 @warning The usefulness of this node is questionable. It may be removed in a future release.
 */
@interface CCNodeMultiplexer : CCNode {
	unsigned int _enabledNode;
	NSMutableArray *_nodes;
}

/// -----------------------------------------------------------------------
/// @name Creating a CCNodeMultiplexer Object
/// -----------------------------------------------------------------------

/*
 *  Creates a CCNodeMultiplexer with an array of nodes.
 *
 *  @param arrayOfNodes Array of nodes.
 *
 *  @return The CCNodeMultiplexer object.
 */
+(instancetype)nodeWithArray:(NSArray*)arrayOfNodes;

/* Creates a CCMultiplexLayer with one or more nodes using a variable argument list.
 *  Example: 
 *  @code mux = [CCNodeMultiplexer nodeWithNodes:nodeA, nodeB, nodeC, nil];
 *  
 *  @param node List of nodes.
 *  @param ... Nil terminator.
 *  @return The CCNodeMultiplexer object.
 */
+(instancetype)nodeWithNodes:(CCNode*)node, ... NS_REQUIRES_NIL_TERMINATION;


/// -----------------------------------------------------------------------
/// @name Initializing a CCNodeMultiplexer Object
/// -----------------------------------------------------------------------

/*
 *  Initializes a CCNodeMultiplexer with an array of nodes.
 *
 *  @param arrayOfNodes Array of nodes.
 *
 *  @return An initialized CCNodeMultiplexer Object.
 */

-(id)initWithArray:(NSArray*)arrayOfNodes;


/// -----------------------------------------------------------------------
/// @name CCNodeMultiplexer Management
/// -----------------------------------------------------------------------

/*
 *  Switches to a certain node indexed by n.
 *
 *  The current (old) node will be removed from its parent with 'cleanup:YES'.
 *
 *  @param n Index of node to switch to.
 */
-(void)switchTo:(unsigned int) n;

@end

