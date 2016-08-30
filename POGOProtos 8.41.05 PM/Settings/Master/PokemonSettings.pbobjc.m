// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: POGOProtos/Settings/Master/PokemonSettings.proto

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

 #import "POGOProtos/Settings/Master/PokemonSettings.pbobjc.h"
 #import "POGOProtos/Enums/PokemonId.pbobjc.h"
 #import "POGOProtos/Enums/PokemonRarity.pbobjc.h"
 #import "POGOProtos/Enums/PokemonType.pbobjc.h"
 #import "POGOProtos/Enums/PokemonMove.pbobjc.h"
 #import "POGOProtos/Enums/PokemonFamilyId.pbobjc.h"
 #import "POGOProtos/Settings/Master/Pokemon/StatsAttributes.pbobjc.h"
 #import "POGOProtos/Settings/Master/Pokemon/CameraAttributes.pbobjc.h"
 #import "POGOProtos/Settings/Master/Pokemon/EncounterAttributes.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - PokemonSettingsRoot

@implementation PokemonSettingsRoot

+ (GPBExtensionRegistry*)extensionRegistry {
  // This is called by +initialize so there is no need to worry
  // about thread safety and initialization of registry.
  static GPBExtensionRegistry* registry = nil;
  if (!registry) {
    GPBDebugCheckRuntimeVersion();
    registry = [[GPBExtensionRegistry alloc] init];
    [registry addExtensions:[PokemonIdRoot extensionRegistry]];
    [registry addExtensions:[PokemonRarityRoot extensionRegistry]];
    [registry addExtensions:[PokemonTypeRoot extensionRegistry]];
    [registry addExtensions:[PokemonMoveRoot extensionRegistry]];
    [registry addExtensions:[PokemonFamilyIdRoot extensionRegistry]];
    [registry addExtensions:[StatsAttributesRoot extensionRegistry]];
    [registry addExtensions:[CameraAttributesRoot extensionRegistry]];
    [registry addExtensions:[EncounterAttributesRoot extensionRegistry]];
  }
  return registry;
}

@end

#pragma mark - PokemonSettingsRoot_FileDescriptor

static GPBFileDescriptor *PokemonSettingsRoot_FileDescriptor(void) {
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

#pragma mark - PokemonSettings

@implementation PokemonSettings

@dynamic pokemonId;
@dynamic modelScale;
@dynamic type;
@dynamic type2;
@dynamic hasCamera, camera;
@dynamic hasEncounter, encounter;
@dynamic hasStats, stats;
@dynamic quickMovesArray, quickMovesArray_Count;
@dynamic cinematicMovesArray, cinematicMovesArray_Count;
@dynamic animationTimeArray, animationTimeArray_Count;
@dynamic evolutionIdsArray, evolutionIdsArray_Count;
@dynamic evolutionPips;
@dynamic rarity;
@dynamic pokedexHeightM;
@dynamic pokedexWeightKg;
@dynamic parentPokemonId;
@dynamic heightStdDev;
@dynamic weightStdDev;
@dynamic kmDistanceToHatch;
@dynamic familyId;
@dynamic candyToEvolve;
@dynamic kmBuddyDistance;
@dynamic buddySize;

typedef struct PokemonSettings__storage_ {
  uint32_t _has_storage_[1];
  PokemonId pokemonId;
  float modelScale;
  PokemonType type;
  PokemonType type2;
  int32_t evolutionPips;
  PokemonRarity rarity;
  float pokedexHeightM;
  float pokedexWeightKg;
  PokemonId parentPokemonId;
  float heightStdDev;
  float weightStdDev;
  float kmDistanceToHatch;
  PokemonFamilyId familyId;
  int32_t candyToEvolve;
  float kmBuddyDistance;
  PokemonSettings_BuddySize buddySize;
  CameraAttributes *camera;
  EncounterAttributes *encounter;
  StatsAttributes *stats;
  GPBEnumArray *quickMovesArray;
  GPBEnumArray *cinematicMovesArray;
  GPBFloatArray *animationTimeArray;
  GPBEnumArray *evolutionIdsArray;
} PokemonSettings__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "pokemonId",
        .dataTypeSpecific.enumDescFunc = PokemonId_EnumDescriptor,
        .number = PokemonSettings_FieldNumber_PokemonId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, pokemonId),
        .flags = GPBFieldOptional | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "modelScale",
        .dataTypeSpecific.className = NULL,
        .number = PokemonSettings_FieldNumber_ModelScale,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, modelScale),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeFloat,
      },
      {
        .name = "type",
        .dataTypeSpecific.enumDescFunc = PokemonType_EnumDescriptor,
        .number = PokemonSettings_FieldNumber_Type,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, type),
        .flags = GPBFieldOptional | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "type2",
        .dataTypeSpecific.enumDescFunc = PokemonType_EnumDescriptor,
        .number = PokemonSettings_FieldNumber_Type2,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, type2),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "camera",
        .dataTypeSpecific.className = GPBStringifySymbol(CameraAttributes),
        .number = PokemonSettings_FieldNumber_Camera,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, camera),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "encounter",
        .dataTypeSpecific.className = GPBStringifySymbol(EncounterAttributes),
        .number = PokemonSettings_FieldNumber_Encounter,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, encounter),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "stats",
        .dataTypeSpecific.className = GPBStringifySymbol(StatsAttributes),
        .number = PokemonSettings_FieldNumber_Stats,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, stats),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "quickMovesArray",
        .dataTypeSpecific.enumDescFunc = PokemonMove_EnumDescriptor,
        .number = PokemonSettings_FieldNumber_QuickMovesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, quickMovesArray),
        .flags = GPBFieldRepeated | GPBFieldPacked | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "cinematicMovesArray",
        .dataTypeSpecific.enumDescFunc = PokemonMove_EnumDescriptor,
        .number = PokemonSettings_FieldNumber_CinematicMovesArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, cinematicMovesArray),
        .flags = GPBFieldRepeated | GPBFieldPacked | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "animationTimeArray",
        .dataTypeSpecific.className = NULL,
        .number = PokemonSettings_FieldNumber_AnimationTimeArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, animationTimeArray),
        .flags = GPBFieldRepeated | GPBFieldPacked,
        .dataType = GPBDataTypeFloat,
      },
      {
        .name = "evolutionIdsArray",
        .dataTypeSpecific.enumDescFunc = PokemonId_EnumDescriptor,
        .number = PokemonSettings_FieldNumber_EvolutionIdsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, evolutionIdsArray),
        .flags = GPBFieldRepeated | GPBFieldPacked | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "evolutionPips",
        .dataTypeSpecific.className = NULL,
        .number = PokemonSettings_FieldNumber_EvolutionPips,
        .hasIndex = 7,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, evolutionPips),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "rarity",
        .dataTypeSpecific.enumDescFunc = PokemonRarity_EnumDescriptor,
        .number = PokemonSettings_FieldNumber_Rarity,
        .hasIndex = 8,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, rarity),
        .flags = GPBFieldOptional | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "pokedexHeightM",
        .dataTypeSpecific.className = NULL,
        .number = PokemonSettings_FieldNumber_PokedexHeightM,
        .hasIndex = 9,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, pokedexHeightM),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeFloat,
      },
      {
        .name = "pokedexWeightKg",
        .dataTypeSpecific.className = NULL,
        .number = PokemonSettings_FieldNumber_PokedexWeightKg,
        .hasIndex = 10,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, pokedexWeightKg),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeFloat,
      },
      {
        .name = "parentPokemonId",
        .dataTypeSpecific.enumDescFunc = PokemonId_EnumDescriptor,
        .number = PokemonSettings_FieldNumber_ParentPokemonId,
        .hasIndex = 11,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, parentPokemonId),
        .flags = GPBFieldOptional | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "heightStdDev",
        .dataTypeSpecific.className = NULL,
        .number = PokemonSettings_FieldNumber_HeightStdDev,
        .hasIndex = 12,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, heightStdDev),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeFloat,
      },
      {
        .name = "weightStdDev",
        .dataTypeSpecific.className = NULL,
        .number = PokemonSettings_FieldNumber_WeightStdDev,
        .hasIndex = 13,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, weightStdDev),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeFloat,
      },
      {
        .name = "kmDistanceToHatch",
        .dataTypeSpecific.className = NULL,
        .number = PokemonSettings_FieldNumber_KmDistanceToHatch,
        .hasIndex = 14,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, kmDistanceToHatch),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeFloat,
      },
      {
        .name = "familyId",
        .dataTypeSpecific.enumDescFunc = PokemonFamilyId_EnumDescriptor,
        .number = PokemonSettings_FieldNumber_FamilyId,
        .hasIndex = 15,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, familyId),
        .flags = GPBFieldOptional | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
      {
        .name = "candyToEvolve",
        .dataTypeSpecific.className = NULL,
        .number = PokemonSettings_FieldNumber_CandyToEvolve,
        .hasIndex = 16,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, candyToEvolve),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "kmBuddyDistance",
        .dataTypeSpecific.className = NULL,
        .number = PokemonSettings_FieldNumber_KmBuddyDistance,
        .hasIndex = 17,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, kmBuddyDistance),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeFloat,
      },
      {
        .name = "buddySize",
        .dataTypeSpecific.enumDescFunc = PokemonSettings_BuddySize_EnumDescriptor,
        .number = PokemonSettings_FieldNumber_BuddySize,
        .hasIndex = 18,
        .offset = (uint32_t)offsetof(PokemonSettings__storage_, buddySize),
        .flags = GPBFieldOptional | GPBFieldHasEnumDescriptor,
        .dataType = GPBDataTypeEnum,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[PokemonSettings class]
                                     rootClass:[PokemonSettingsRoot class]
                                          file:PokemonSettingsRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(PokemonSettings__storage_)
                                         flags:0];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\001\005\004\201\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t PokemonSettings_PokemonId_RawValue(PokemonSettings *message) {
  GPBDescriptor *descriptor = [PokemonSettings descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PokemonSettings_FieldNumber_PokemonId];
  return GPBGetMessageInt32Field(message, field);
}

void SetPokemonSettings_PokemonId_RawValue(PokemonSettings *message, int32_t value) {
  GPBDescriptor *descriptor = [PokemonSettings descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PokemonSettings_FieldNumber_PokemonId];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

int32_t PokemonSettings_Type_RawValue(PokemonSettings *message) {
  GPBDescriptor *descriptor = [PokemonSettings descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PokemonSettings_FieldNumber_Type];
  return GPBGetMessageInt32Field(message, field);
}

void SetPokemonSettings_Type_RawValue(PokemonSettings *message, int32_t value) {
  GPBDescriptor *descriptor = [PokemonSettings descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PokemonSettings_FieldNumber_Type];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

int32_t PokemonSettings_Type2_RawValue(PokemonSettings *message) {
  GPBDescriptor *descriptor = [PokemonSettings descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PokemonSettings_FieldNumber_Type2];
  return GPBGetMessageInt32Field(message, field);
}

void SetPokemonSettings_Type2_RawValue(PokemonSettings *message, int32_t value) {
  GPBDescriptor *descriptor = [PokemonSettings descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PokemonSettings_FieldNumber_Type2];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

int32_t PokemonSettings_Rarity_RawValue(PokemonSettings *message) {
  GPBDescriptor *descriptor = [PokemonSettings descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PokemonSettings_FieldNumber_Rarity];
  return GPBGetMessageInt32Field(message, field);
}

void SetPokemonSettings_Rarity_RawValue(PokemonSettings *message, int32_t value) {
  GPBDescriptor *descriptor = [PokemonSettings descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PokemonSettings_FieldNumber_Rarity];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

int32_t PokemonSettings_ParentPokemonId_RawValue(PokemonSettings *message) {
  GPBDescriptor *descriptor = [PokemonSettings descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PokemonSettings_FieldNumber_ParentPokemonId];
  return GPBGetMessageInt32Field(message, field);
}

void SetPokemonSettings_ParentPokemonId_RawValue(PokemonSettings *message, int32_t value) {
  GPBDescriptor *descriptor = [PokemonSettings descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PokemonSettings_FieldNumber_ParentPokemonId];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

int32_t PokemonSettings_FamilyId_RawValue(PokemonSettings *message) {
  GPBDescriptor *descriptor = [PokemonSettings descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PokemonSettings_FieldNumber_FamilyId];
  return GPBGetMessageInt32Field(message, field);
}

void SetPokemonSettings_FamilyId_RawValue(PokemonSettings *message, int32_t value) {
  GPBDescriptor *descriptor = [PokemonSettings descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PokemonSettings_FieldNumber_FamilyId];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

int32_t PokemonSettings_BuddySize_RawValue(PokemonSettings *message) {
  GPBDescriptor *descriptor = [PokemonSettings descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PokemonSettings_FieldNumber_BuddySize];
  return GPBGetMessageInt32Field(message, field);
}

void SetPokemonSettings_BuddySize_RawValue(PokemonSettings *message, int32_t value) {
  GPBDescriptor *descriptor = [PokemonSettings descriptor];
  GPBFieldDescriptor *field = [descriptor fieldWithNumber:PokemonSettings_FieldNumber_BuddySize];
  GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - Enum PokemonSettings_BuddySize

GPBEnumDescriptor *PokemonSettings_BuddySize_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "BuddyMedium\000BuddyShoulder\000BuddyBig\000Buddy"
        "Flying\000";
    static const int32_t values[] = {
        PokemonSettings_BuddySize_BuddyMedium,
        PokemonSettings_BuddySize_BuddyShoulder,
        PokemonSettings_BuddySize_BuddyBig,
        PokemonSettings_BuddySize_BuddyFlying,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(PokemonSettings_BuddySize)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:PokemonSettings_BuddySize_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL PokemonSettings_BuddySize_IsValidValue(int32_t value__) {
  switch (value__) {
    case PokemonSettings_BuddySize_BuddyMedium:
    case PokemonSettings_BuddySize_BuddyShoulder:
    case PokemonSettings_BuddySize_BuddyBig:
    case PokemonSettings_BuddySize_BuddyFlying:
      return YES;
    default:
      return NO;
  }
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
