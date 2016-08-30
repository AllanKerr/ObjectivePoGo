// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: POGOProtos/Networking/Responses/FortDetailsResponse.proto

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

 #import "POGOProtos/Networking/Responses/FortDetailsResponse.pbobjc.h"
 #import "POGOProtos/Data/PokemonData.pbobjc.h"
 #import "POGOProtos/Enums/TeamColor.pbobjc.h"
 #import "POGOProtos/Map/Fort/FortType.pbobjc.h"
 #import "POGOProtos/Map/Fort/FortModifier.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - FortDetailsResponseRoot

@implementation FortDetailsResponseRoot

+ (GPBExtensionRegistry*)extensionRegistry {
  // This is called by +initialize so there is no need to worry
  // about thread safety and initialization of registry.
  static GPBExtensionRegistry* registry = nil;
  if (!registry) {
    GPBDebugCheckRuntimeVersion();
    registry = [[GPBExtensionRegistry alloc] init];
    [registry addExtensions:[PokemonDataRoot extensionRegistry]];
    [registry addExtensions:[TeamColorRoot extensionRegistry]];
    [registry addExtensions:[FortTypeRoot extensionRegistry]];
    [registry addExtensions:[FortModifierRoot extensionRegistry]];
  }
  return registry;
}

@end

#pragma mark - FortDetailsResponseRoot_FileDescriptor

static GPBFileDescriptor *FortDetailsResponseRoot_FileDescriptor(void) {
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

#pragma mark - FortDetailsResponse

@implementation FortDetailsResponse

@dynamic fortId;
@dynamic teamColor;
@dynamic hasPokemonData, pokemonData;
@dynamic name;
@dynamic imageUrlsArray, imageUrlsArray_Count;
@dynamic fp;
@dynamic stamina;
@dynamic maxStamina;
@dynamic type;
@dynamic latitude;
@dynamic longitude;
@dynamic description_p;
@dynamic modifiersArray, modifiersArray_Count;

typedef struct FortDetailsResponse__storage_ {
  uint32_t _has_storage_[1];
  TeamColor teamColor;
  int32_t fp;
  int32_t stamina;
  int32_t maxStamina;
  FortType type;
  NSString *fortId;
  PokemonData *pokemonData;
  NSString *name;
  NSMutableArray *imageUrlsArray;
  NSString *description_p;
  NSMutableArray *modifiersArray;
  double latitude;
  double longitude;
} FortDetailsResponse__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "fortId",
        .dataTypeSpecific.className = NULL,
        .number = FortDetailsResponse_FieldNumber_FortId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(FortDetailsResponse__storage_, fortId),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "teamColor",
        .dataTypeSpecific.enumDescFunc = TeamColor_EnumDescriptor,
        .number = FortDetailsResponse_FieldNumber_TeamColor,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(FortDetailsResponse__storage_, teamColor),
        .flags = GPBFieldOptional | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "pokemonData",
        .dataTypeSpecific.className = GPBStringifySymbol(PokemonData),
        .number = FortDetailsResponse_FieldNumber_PokemonData,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(FortDetailsResponse__storage_, pokemonData),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "name",
        .dataTypeSpecific.className = NULL,
        .number = FortDetailsResponse_FieldNumber_Name,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(FortDetailsResponse__storage_, name),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "imageUrlsArray",
        .dataTypeSpecific.className = NULL,
        .number = FortDetailsResponse_FieldNumber_ImageUrlsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(FortDetailsResponse__storage_, imageUrlsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "fp",
        .dataTypeSpecific.className = NULL,
        .number = FortDetailsResponse_FieldNumber_Fp,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(FortDetailsResponse__storage_, fp),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "stamina",
        .dataTypeSpecific.className = NULL,
        .number = FortDetailsResponse_FieldNumber_Stamina,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(FortDetailsResponse__storage_, stamina),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "maxStamina",
        .dataTypeSpecific.className = NULL,
        .number = FortDetailsResponse_FieldNumber_MaxStamina,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(FortDetailsResponse__storage_, maxStamina),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "type",
        .dataTypeSpecific.enumDescFunc = FortType_EnumDescriptor,
        .number = FortDetailsResponse_FieldNumber_Type,
        .hasIndex = 7,
        .offset = (uint32_t)offsetof(FortDetailsResponse__storage_, type),
        .flags = GPBFieldOptional | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "latitude",
        .dataTypeSpecific.className = NULL,
        .number = FortDetailsResponse_FieldNumber_Latitude,
        .hasIndex = 8,
        .offset = (uint32_t)offsetof(FortDetailsResponse__storage_, latitude),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeDouble,
      },
      {
        .name = "longitude",
        .dataTypeSpecific.className = NULL,
        .number = FortDetailsResponse_FieldNumber_Longitude,
        .hasIndex = 9,
        .offset = (uint32_t)offsetof(FortDetailsResponse__storage_, longitude),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeDouble,
      },
      {
        .name = "description_p",
        .dataTypeSpecific.className = NULL,
        .number = FortDetailsResponse_FieldNumber_Description_p,
        .hasIndex = 10,
        .offset = (uint32_t)offsetof(FortDetailsResponse__storage_, description_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "modifiersArray",
        .dataTypeSpecific.className = GPBStringifySymbol(FortModifier),
        .number = FortDetailsResponse_FieldNumber_ModifiersArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(FortDetailsResponse__storage_, modifiersArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[FortDetailsResponse class]
                                     rootClass:[FortDetailsResponseRoot class]
                                          file:FortDetailsResponseRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(FortDetailsResponse__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t FortDetailsResponse_TeamColor_RawValue(FortDetailsResponse *message) {
  GPBDescriptor *descriptor = [FortDetailsResponse descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:FortDetailsResponse_FieldNumber_TeamColor];
  return GPBGetMessageInt32Field(message, field);
}

void SetFortDetailsResponse_TeamColor_RawValue(FortDetailsResponse *message, int32_t value) {
  GPBDescriptor *descriptor = [FortDetailsResponse descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:FortDetailsResponse_FieldNumber_TeamColor];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

int32_t FortDetailsResponse_Type_RawValue(FortDetailsResponse *message) {
  GPBDescriptor *descriptor = [FortDetailsResponse descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:FortDetailsResponse_FieldNumber_Type];
  return GPBGetMessageInt32Field(message, field);
}

void SetFortDetailsResponse_Type_RawValue(FortDetailsResponse *message, int32_t value) {
  GPBDescriptor *descriptor = [FortDetailsResponse descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:FortDetailsResponse_FieldNumber_Type];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
