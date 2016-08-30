// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: POGOProtos/Data/AssetDigestEntry.proto

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

 #import "POGOProtos/Data/AssetDigestEntry.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - AssetDigestEntryRoot

@implementation AssetDigestEntryRoot

@end

#pragma mark - AssetDigestEntryRoot_FileDescriptor

static GPBFileDescriptor *AssetDigestEntryRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPBDebugCheckRuntimeVersion();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"POGOProtos.Data"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - AssetDigestEntry

@implementation AssetDigestEntry

@dynamic assetId;
@dynamic bundleName;
@dynamic version;
@dynamic checksum;
@dynamic size;
@dynamic key;

typedef struct AssetDigestEntry__storage_ {
  uint32_t _has_storage_[1];
  uint32_t checksum;
  int32_t size;
  NSString *assetId;
  NSString *bundleName;
  NSData *key;
  int64_t version;
} AssetDigestEntry__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "assetId",
        .dataTypeSpecific.className = NULL,
        .number = AssetDigestEntry_FieldNumber_AssetId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(AssetDigestEntry__storage_, assetId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "bundleName",
        .dataTypeSpecific.className = NULL,
        .number = AssetDigestEntry_FieldNumber_BundleName,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(AssetDigestEntry__storage_, bundleName),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "version",
        .dataTypeSpecific.className = NULL,
        .number = AssetDigestEntry_FieldNumber_Version,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(AssetDigestEntry__storage_, version),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
      {
        .name = "checksum",
        .dataTypeSpecific.className = NULL,
        .number = AssetDigestEntry_FieldNumber_Checksum,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(AssetDigestEntry__storage_, checksum),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeFixed32,
      },
      {
        .name = "size",
        .dataTypeSpecific.className = NULL,
        .number = AssetDigestEntry_FieldNumber_Size,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(AssetDigestEntry__storage_, size),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "key",
        .dataTypeSpecific.className = NULL,
        .number = AssetDigestEntry_FieldNumber_Key,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(AssetDigestEntry__storage_, key),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeBytes,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[AssetDigestEntry class]
                                     rootClass:[AssetDigestEntryRoot class]
                                          file:AssetDigestEntryRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(AssetDigestEntry__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
