// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: POGOProtos/Networking/Responses/GetAssetDigestResponse.proto

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

 #import "POGOProtos/Networking/Responses/GetAssetDigestResponse.pbobjc.h"
 #import "POGOProtos/Data/AssetDigestEntry.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - GetAssetDigestResponseRoot

@implementation GetAssetDigestResponseRoot

+ (GPBExtensionRegistry*)extensionRegistry {
  // This is called by +initialize so there is no need to worry
  // about thread safety and initialization of registry.
  static GPBExtensionRegistry* registry = nil;
  if (!registry) {
    GPBDebugCheckRuntimeVersion();
    registry = [[GPBExtensionRegistry alloc] init];
    [registry addExtensions:[AssetDigestEntryRoot extensionRegistry]];
  }
  return registry;
}

@end

#pragma mark - GetAssetDigestResponseRoot_FileDescriptor

static GPBFileDescriptor *GetAssetDigestResponseRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPBDebugCheckRuntimeVersion();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"POGOProtos.Networking.Responses"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - GetAssetDigestResponse

@implementation GetAssetDigestResponse

@dynamic digestArray, digestArray_Count;
@dynamic timestampMs;

typedef struct GetAssetDigestResponse__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *digestArray;
  uint64_t timestampMs;
} GetAssetDigestResponse__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "digestArray",
        .dataTypeSpecific.className = GPBStringifySymbol(AssetDigestEntry),
        .number = GetAssetDigestResponse_FieldNumber_DigestArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(GetAssetDigestResponse__storage_, digestArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "timestampMs",
        .dataTypeSpecific.className = NULL,
        .number = GetAssetDigestResponse_FieldNumber_TimestampMs,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(GetAssetDigestResponse__storage_, timestampMs),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeUInt64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[GetAssetDigestResponse class]
                                     rootClass:[GetAssetDigestResponseRoot class]
                                          file:GetAssetDigestResponseRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(GetAssetDigestResponse__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
