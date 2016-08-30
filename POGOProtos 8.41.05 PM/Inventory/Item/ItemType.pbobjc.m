// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: POGOProtos/Inventory/Item/ItemType.proto

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

 #import "POGOProtos/Inventory/Item/ItemType.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - ItemTypeRoot

@implementation ItemTypeRoot

@end

#pragma mark - Enum ItemType

GPBEnumDescriptor *ItemType_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "ItemTypeNone\000ItemTypePokeball\000ItemTypePo"
        "tion\000ItemTypeRevive\000ItemTypeMap\000ItemType"
        "Battle\000ItemTypeFood\000ItemTypeCamera\000ItemT"
        "ypeDisk\000ItemTypeIncubator\000ItemTypeIncens"
        "e\000ItemTypeXpBoost\000ItemTypeInventoryUpgra"
        "de\000";
    static const int32_t values[] = {
        ItemType_ItemTypeNone,
        ItemType_ItemTypePokeball,
        ItemType_ItemTypePotion,
        ItemType_ItemTypeRevive,
        ItemType_ItemTypeMap,
        ItemType_ItemTypeBattle,
        ItemType_ItemTypeFood,
        ItemType_ItemTypeCamera,
        ItemType_ItemTypeDisk,
        ItemType_ItemTypeIncubator,
        ItemType_ItemTypeIncense,
        ItemType_ItemTypeXpBoost,
        ItemType_ItemTypeInventoryUpgrade,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(ItemType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:ItemType_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL ItemType_IsValidValue(int32_t value__) {
  switch (value__) {
    case ItemType_ItemTypeNone:
    case ItemType_ItemTypePokeball:
    case ItemType_ItemTypePotion:
    case ItemType_ItemTypeRevive:
    case ItemType_ItemTypeMap:
    case ItemType_ItemTypeBattle:
    case ItemType_ItemTypeFood:
    case ItemType_ItemTypeCamera:
    case ItemType_ItemTypeDisk:
    case ItemType_ItemTypeIncubator:
    case ItemType_ItemTypeIncense:
    case ItemType_ItemTypeXpBoost:
    case ItemType_ItemTypeInventoryUpgrade:
      return YES;
    default:
      return NO;
  }
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
