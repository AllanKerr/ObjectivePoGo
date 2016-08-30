// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: POGOProtos/Map/MapObjectsStatus.proto

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

 #import "POGOProtos/Map/MapObjectsStatus.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - MapObjectsStatusRoot

@implementation MapObjectsStatusRoot

@end

#pragma mark - Enum MapObjectsStatus

GPBEnumDescriptor *MapObjectsStatus_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "UnsetStatus\000Success\000LocationUnset\000";
    static const int32_t values[] = {
        MapObjectsStatus_UnsetStatus,
        MapObjectsStatus_Success,
        MapObjectsStatus_LocationUnset,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(MapObjectsStatus)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:MapObjectsStatus_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL MapObjectsStatus_IsValidValue(int32_t value__) {
  switch (value__) {
    case MapObjectsStatus_UnsetStatus:
    case MapObjectsStatus_Success:
    case MapObjectsStatus_LocationUnset:
      return YES;
    default:
      return NO;
  }
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
