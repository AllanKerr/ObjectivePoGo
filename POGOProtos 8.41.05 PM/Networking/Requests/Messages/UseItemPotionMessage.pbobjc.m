// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: POGOProtos/Networking/Requests/Messages/UseItemPotionMessage.proto

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

 #import "POGOProtos/Networking/Requests/Messages/UseItemPotionMessage.pbobjc.h"
 #import "POGOProtos/Inventory/Item/ItemId.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - UseItemPotionMessageRoot

@implementation UseItemPotionMessageRoot

+ (GPBExtensionRegistry*)extensionRegistry {
  // This is called by +initialize so there is no need to worry
  // about thread safety and initialization of registry.
  static GPBExtensionRegistry* registry = nil;
  if (!registry) {
    GPBDebugCheckRuntimeVersion();
    registry = [[GPBExtensionRegistry alloc] init];
    [registry addExtensions:[ItemIdRoot extensionRegistry]];
  }
  return registry;
}

@end

#pragma mark - UseItemPotionMessageRoot_FileDescriptor

static GPBFileDescriptor *UseItemPotionMessageRoot_FileDescriptor(void) {
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

#pragma mark - UseItemPotionMessage

@implementation UseItemPotionMessage

@dynamic itemId;
@dynamic pokemonId;

typedef struct UseItemPotionMessage__storage_ {
  uint32_t _has_storage_[1];
  ItemId itemId;
  uint64_t pokemonId;
} UseItemPotionMessage__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "itemId",
        .dataTypeSpecific.enumDescFunc = ItemId_EnumDescriptor,
        .number = UseItemPotionMessage_FieldNumber_ItemId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(UseItemPotionMessage__storage_, itemId),
        .flags = GPBFieldOptional | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "pokemonId",
        .dataTypeSpecific.className = NULL,
        .number = UseItemPotionMessage_FieldNumber_PokemonId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(UseItemPotionMessage__storage_, pokemonId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeFixed64,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[UseItemPotionMessage class]
                                     rootClass:[UseItemPotionMessageRoot class]
                                          file:UseItemPotionMessageRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(UseItemPotionMessage__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t UseItemPotionMessage_ItemId_RawValue(UseItemPotionMessage *message) {
  GPBDescriptor *descriptor = [UseItemPotionMessage descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:UseItemPotionMessage_FieldNumber_ItemId];
  return GPBGetMessageInt32Field(message, field);
}

void SetUseItemPotionMessage_ItemId_RawValue(UseItemPotionMessage *message, int32_t value) {
  GPBDescriptor *descriptor = [UseItemPotionMessage descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:UseItemPotionMessage_FieldNumber_ItemId];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
