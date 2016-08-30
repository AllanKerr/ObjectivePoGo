// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: POGOProtos/Networking/Responses/UpgradePokemonResponse.proto

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

 #import "POGOProtos/Networking/Responses/UpgradePokemonResponse.pbobjc.h"
 #import "POGOProtos/Data/PokemonData.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - UpgradePokemonResponseRoot

@implementation UpgradePokemonResponseRoot

+ (GPBExtensionRegistry*)extensionRegistry {
  // This is called by +initialize so there is no need to worry
  // about thread safety and initialization of registry.
  static GPBExtensionRegistry* registry = nil;
  if (!registry) {
    GPBDebugCheckRuntimeVersion();
    registry = [[GPBExtensionRegistry alloc] init];
    [registry addExtensions:[PokemonDataRoot extensionRegistry]];
  }
  return registry;
}

@end

#pragma mark - UpgradePokemonResponseRoot_FileDescriptor

static GPBFileDescriptor *UpgradePokemonResponseRoot_FileDescriptor(void) {
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

#pragma mark - UpgradePokemonResponse

@implementation UpgradePokemonResponse

@dynamic result;
@dynamic hasUpgradedPokemon, upgradedPokemon;

typedef struct UpgradePokemonResponse__storage_ {
  uint32_t _has_storage_[1];
  UpgradePokemonResponse_Result result;
  PokemonData *upgradedPokemon;
} UpgradePokemonResponse__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "result",
        .dataTypeSpecific.enumDescFunc = UpgradePokemonResponse_Result_EnumDescriptor,
        .number = UpgradePokemonResponse_FieldNumber_Result,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(UpgradePokemonResponse__storage_, result),
        .flags = GPBFieldOptional | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "upgradedPokemon",
        .dataTypeSpecific.className = GPBStringifySymbol(PokemonData),
        .number = UpgradePokemonResponse_FieldNumber_UpgradedPokemon,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(UpgradePokemonResponse__storage_, upgradedPokemon),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[UpgradePokemonResponse class]
                                     rootClass:[UpgradePokemonResponseRoot class]
                                          file:UpgradePokemonResponseRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(UpgradePokemonResponse__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t UpgradePokemonResponse_Result_RawValue(UpgradePokemonResponse *message) {
  GPBDescriptor *descriptor = [UpgradePokemonResponse descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:UpgradePokemonResponse_FieldNumber_Result];
  return GPBGetMessageInt32Field(message, field);
}

void SetUpgradePokemonResponse_Result_RawValue(UpgradePokemonResponse *message, int32_t value) {
  GPBDescriptor *descriptor = [UpgradePokemonResponse descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:UpgradePokemonResponse_FieldNumber_Result];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - Enum UpgradePokemonResponse_Result

GPBEnumDescriptor *UpgradePokemonResponse_Result_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "Unset\000Success\000ErrorPokemonNotFound\000Error"
        "InsufficientResources\000ErrorUpgradeNotAva"
        "ilable\000ErrorPokemonIsDeployed\000";
    static const int32_t values[] = {
        UpgradePokemonResponse_Result_Unset,
        UpgradePokemonResponse_Result_Success,
        UpgradePokemonResponse_Result_ErrorPokemonNotFound,
        UpgradePokemonResponse_Result_ErrorInsufficientResources,
        UpgradePokemonResponse_Result_ErrorUpgradeNotAvailable,
        UpgradePokemonResponse_Result_ErrorPokemonIsDeployed,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(UpgradePokemonResponse_Result)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:UpgradePokemonResponse_Result_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL UpgradePokemonResponse_Result_IsValidValue(int32_t value__) {
  switch (value__) {
    case UpgradePokemonResponse_Result_Unset:
    case UpgradePokemonResponse_Result_Success:
    case UpgradePokemonResponse_Result_ErrorPokemonNotFound:
    case UpgradePokemonResponse_Result_ErrorInsufficientResources:
    case UpgradePokemonResponse_Result_ErrorUpgradeNotAvailable:
    case UpgradePokemonResponse_Result_ErrorPokemonIsDeployed:
      return YES;
    default:
      return NO;
  }
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
