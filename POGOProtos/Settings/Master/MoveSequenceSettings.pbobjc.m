// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: POGOProtos/Settings/Master/MoveSequenceSettings.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

 #import "POGOProtos/Settings/Master/MoveSequenceSettings.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - MoveSequenceSettingsRoot

@implementation MoveSequenceSettingsRoot

@end

#pragma mark - MoveSequenceSettingsRoot_FileDescriptor

static GPBFileDescriptor *MoveSequenceSettingsRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPBDebugCheckRuntimeVersion();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"POGOProtos.Settings.Master"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - MoveSequenceSettings

@implementation MoveSequenceSettings

@dynamic sequenceArray, sequenceArray_Count;

typedef struct MoveSequenceSettings__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *sequenceArray;
} MoveSequenceSettings__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "sequenceArray",
        .dataTypeSpecific.className = NULL,
        .number = MoveSequenceSettings_FieldNumber_SequenceArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(MoveSequenceSettings__storage_, sequenceArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[MoveSequenceSettings class]
                                     rootClass:[MoveSequenceSettingsRoot class]
                                          file:MoveSequenceSettingsRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(MoveSequenceSettings__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
