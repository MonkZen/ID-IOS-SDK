/**
 Copyright (c) 2012-2018, Smart Engines Ltd
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice,
 this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 * Neither the name of the Smart Engines Ltd nor the names of its
 contributors may be used to endorse or promote products derived from this
 software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "SmartIDViewControllerSwift.h"
#import "SmartIDViewController+Protected.h"

#import "SmartIDSessionSettings+CPP.h"

@interface SmartIDViewControllerSwift () <SmartIDViewControllerProtected>

@end

@implementation SmartIDViewControllerSwift
@synthesize camera, videoEngine, quadrangleView, previewLayer;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self cancelButton] addTarget:self
                            action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (SmartIDSessionSettings *) getSessionSettings {
    return [[self videoEngine] settings];
}

- (void) addEnabledDocTypesMask:(NSString *)documentTypesMask {
    [[[self videoEngine] settings] addEnabledDocumentTypes:documentTypesMask];
}
- (void) removeEnabledDocTypesMask:(NSString *)documentTypesMask {
    [[[self videoEngine] settings] removeEnabledDocumentTypes:documentTypesMask];
}

- (void) setEnabledDocTypes:(NSArray<NSString *> *)documentTypes {
    [[[self videoEngine] settings] setEnabledDocumentTypes:documentTypes];
}
- (NSArray<NSString *> *) enabledDocTypes {
    return [[[self videoEngine] settings] getEnabledDocumentTypes];
}

- (NSArray<NSArray<NSString *> *> *) supportedDocTypes {
    return [[[self videoEngine] settings] getSupportedDocumentTypes];
}

- (void)smartIDVideoProcessingEngineDidRecognizeResult:(SmartIDRecognitionResult *)smartIdResult fromBuffer:(CMSampleBufferRef)buffer {
    [super smartIDVideoProcessingEngineDidRecognizeResult:smartIdResult fromBuffer:buffer];
    if ([[self smartIDDelegate] respondsToSelector:@selector(smartIDViewControllerDidRecognize:fromBuffer:)]) {
        [[self smartIDDelegate] smartIDViewControllerDidRecognize:smartIdResult fromBuffer:buffer];
    }
}

- (void)smartIDVideoProcessingEngineDidRecognizeResult:(SmartIDRecognitionResult *)smartIdResult {
    [super smartIDVideoProcessingEngineDidRecognizeResult:smartIdResult];
    [[self smartIDDelegate] smartIDViewControllerDidRecognize:smartIdResult];
}

- (void)smartIDVideoProcessingEngineDidSegmentResult:(NSArray<SmartIDSegmentationResult *> *)quads {
    [super smartIDVideoProcessingEngineDidSegmentResult:quads];
}

- (void)smartIDVideoProcessingEngineDidReceiveFeedback:(SmartIDProcessingFeedback *)processingFeedback {
    [super smartIDVideoProcessingEngineDidReceiveFeedback:processingFeedback];
}

- (void)smartIDVideoProcessingEngineDidMatchResult:(NSArray<SmartIDMatchResult *> *)quads {
    [super smartIDVideoProcessingEngineDidMatchResult:quads];
}

- (void) cancelButtonPressed {
    [[self smartIDDelegate] smartIDviewControllerDidCancel];
}

- (void) setMode:(nonnull NSString *)stringMode {
    [[[self videoEngine] settings] setMode:stringMode];
}

- (nonnull NSArray <NSString *> *) availableModes {
    return [[[self videoEngine] settings] getAvailableModes];
}

- (nonnull NSString *) version {
    return [SmartIDViewController version];
}

@end
