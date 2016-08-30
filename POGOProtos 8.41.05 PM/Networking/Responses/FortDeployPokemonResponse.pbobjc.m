// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: POGOProtos/Networking/Responses/FortDeployPokemonResponse.proto

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

 #import "POGOProtos/Networking/Responses/FortDeployPokemonResponse.pbobjc.h"
 #import "POGOProtos/Data/PokemonData.pbobjc.h"
 #import "POGOProtos/Data/Gym/GymState.pbobjc.h"
 #import "POGOProtos/Networking/Responses/FortDetailsResponse.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - FortDeployPokemonResponseRoot

@implementation FortDeployPokemonResponseRoot

+ (GPBExtensionRegistry*)extensionRegistry {
  // This is called by +initialize so there is no need to worry
  // about thread safety and initialization of registry.
  static GPBExtensionRegistry* registry = nil;
  if (!registry) {
    GPBDebugCheckRuntimeVersion();
    registry = [[GPBExtensionRegistry alloc] init];
    [registry addExtensions:[PokemonDataRoot extensionRegistry]];
    [registry addExtensions:[GymStateRoot extensionRegistry]];
    [registry addExtensions:[FortDetailsResponseRoot extensionRegistry]];
  }
  return registry;
}

@end

#pragma mark - FortDeployPokemonResponseRoot_FileDescriptor

static GPBFileDescriptor *FortDeployPokemonResponseRoot_FileDescriptor(void) {
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

#pragma mark - FortDeployPokemonResponse

@implementation FortDeployPokemonResponse

@dynamic result;
@dynamic hasFortDetails, fortDetails;
@dynamic hasPokemonData, pokemonData;
@dynamic hasGymState, gymState;

typedef struct FortDeployPokemonResponse__storage_ {
  uint32_t _has_storage_[1];
  FortDeployPokemonResponse_Result result;
  FortDetailsResponse *fortDetails;
  PokemonData *pokemonData;
  GymState *gymState;
} FortDeployPokemonResponse__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "result",
        .dataTypeSpecific.enumDescFunc = FortDeployPokemonResponse_Result_EnumDescriptor,
        .number = FortDeployPokemonResponse_FieldNumber_Result,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(FortDeployPokemonResponse__storage_, result),
        .flags = GPBFieldOptional | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "fortDetails",
        .dataTypeSpecific.className = GPBStringifySymbol(FortDetailsResponse),
        .number = FortDeployPokemonResponse_FieldNumber_FortDetails,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(FortDeployPokemonResponse__storage_, fortDetails),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "pokemonData",
        .dataTypeSpecific.className = GPBStringifySymbol(PokemonData),
        .number = FortDeployPokemonResponse_FieldNumber_PokemonData,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(FortDeployPokemonResponse__storage_, pokemonData),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "gymState",
        .dataTypeSpecific.className = GPBStringifySymbol(GymState),
        .number = FortDeployPokemonResponse_FieldNumber_GymState,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(FortDeployPokemonResponse__storage_, gymState),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[FortDeployPokemonResponse class]
                                     rootClass:[FortDeployPokemonResponseRoot class]
                                          file:FortDeployPokemonResponseRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(FortDeployPokemonResponse__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t FortDeployPokemonResponse_Result_RawValue(FortDeployPokemonResponse *message) {
  GPBDescriptor *descriptor = [FortDeployPokemonResponse descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:FortDeployPokemonResponse_FieldNumber_Result];
  return GPBGetMessageInt32Field(message, field);
}

void SetFortDeployPokemonResponse_Result_RawValue(FortDeployPokemonResponse *message, int32_t value) {
  GPBDescriptor *descriptor = [FortDeployPokemonResponse descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:FortDeployPokemonResponse_FieldNumber_Result];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - Enum FortDeployPokemonResponse_Result

GPBEnumDescriptor *FortDeployPokemonResponse_Result_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "NoResultSet\000Success\000ErrorAlreadyHasPokem"
        "onOnFort\000ErrorOpposingTeamOwnsFort\000Error"
        "FortIsFull\000ErrorNotInRange\000ErrorPlayerHa"
        "sNoTeam\000ErrorPokemonNotFullHp\000ErrorPlaye"
        "rBelowMinimumLevel\000ErrorPokemonIsBuddy\000";
    static const int32_t values[] = {
        FortDeployPokemonResponse_Result_NoResultSet,
        FortDeployPokemonResponse_Result_Success,
        FortDeployPokemonResponse_Result_ErrorAlreadyHasPokemonOnFort,
        FortDeployPokemonResponse_Result_ErrorOpposingTeamOwnsFort,
        FortDeployPokemonResponse_Result_ErrorFortIsFull,
        FortDeployPokemonResponse_Result_ErrorNotInRange,
        FortDeployPokemonResponse_Result_ErrorPlayerHasNoTeam,
        FortDeployPokemonResponse_Result_ErrorPokemonNotFullHp,
        FortDeployPokemonResponse_Result_ErrorPlayerBelowMinimumLevel,
        FortDeployPokemonResponse_Result_ErrorPokemonIsBuddy,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(FortDeployPokemonResponse_Result)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:FortDeployPokemonResponse_Result_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL FortDeployPokemonResponse_Result_IsValidValue(int32_t value__) {
  switch (value__) {
    case FortDeployPokemonResponse_Result_NoResultSet:
    case FortDeployPokemonResponse_Result_Success:
    case FortDeployPokemonResponse_Result_ErrorAlreadyHasPokemonOnFort:
    case FortDeployPokemonResponse_Result_ErrorOpposingTeamOwnsFort:
    case FortDeployPokemonResponse_Result_ErrorFortIsFull:
    case FortDeployPokemonResponse_Result_ErrorNotInRange:
    case FortDeployPokemonResponse_Result_ErrorPlayerHasNoTeam:
    case FortDeployPokemonResponse_Result_ErrorPokemonNotFullHp:
    case FortDeployPokemonResponse_Result_ErrorPlayerBelowMinimumLevel:
    case FortDeployPokemonResponse_Result_ErrorPokemonIsBuddy:
      return YES;
    default:
      return NO;
  }
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
