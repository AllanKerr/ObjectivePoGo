// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: POGOProtos/Networking/Requests/Messages/GetIncensePokemonMessage.proto

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

 #import "POGOProtos/Networking/Requests/Messages/GetIncensePokemonMessage.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - GetIncensePokemonMessageRoot

@implementation GetIncensePokemonMessageRoot

@end

#pragma mark - GetIncensePokemonMessageRoot_FileDescriptor

static GPBFileDescriptor *GetIncensePokemonMessageRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPBDebugCheckRuntimeVersion();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"POGOProtos.Networking.Requests.Messages"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - GetIncensePokemonMessage

@implementation GetIncensePokemonMessage

@dynamic playerLatitude;
@dynamic playerLongitude;

typedef struct GetIncensePokemonMessage__storage_ {
  uint32_t _has_storage_[1];
  double playerLatitude;
  double playerLongitude;
} GetIncensePokemonMessage__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "playerLatitude",
        .dataTypeSpecific.className = NULL,
        .number = GetIncensePokemonMessage_FieldNumber_PlayerLatitude,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(GetIncensePokemonMessage__storage_, playerLatitude),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeDouble,
      },
      {
        .name = "playerLongitude",
        .dataTypeSpecific.className = NULL,
        .number = GetIncensePokemonMessage_FieldNumber_PlayerLongitude,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(GetIncensePokemonMessage__storage_, playerLongitude),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeDouble,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[GetIncensePokemonMessage class]
                                     rootClass:[GetIncensePokemonMessageRoot class]
                                          file:GetIncensePokemonMessageRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(GetIncensePokemonMessage__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
