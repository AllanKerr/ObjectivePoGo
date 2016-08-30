// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: POGOProtos/Inventory/InventoryItemData.proto

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

 #import "POGOProtos/Inventory/InventoryItemData.pbobjc.h"
 #import "POGOProtos/Inventory/Item/ItemData.pbobjc.h"
 #import "POGOProtos/Inventory/AppliedItems.pbobjc.h"
 #import "POGOProtos/Inventory/EggIncubators.pbobjc.h"
 #import "POGOProtos/Inventory/Candy.pbobjc.h"
 #import "POGOProtos/Inventory/InventoryUpgrades.pbobjc.h"
 #import "POGOProtos/Data/PokemonData.pbobjc.h"
 #import "POGOProtos/Data/PokedexEntry.pbobjc.h"
 #import "POGOProtos/Data/Player/PlayerStats.pbobjc.h"
 #import "POGOProtos/Data/Player/PlayerCurrency.pbobjc.h"
 #import "POGOProtos/Data/Player/PlayerCamera.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - InventoryItemDataRoot

@implementation InventoryItemDataRoot

+ (GPBExtensionRegistry*)extensionRegistry {
  // This is called by +initialize so there is no need to worry
  // about thread safety and initialization of registry.
  static GPBExtensionRegistry* registry = nil;
  if (!registry) {
    GPBDebugCheckRuntimeVersion();
    registry = [[GPBExtensionRegistry alloc] init];
    [registry addExtensions:[ItemDataRoot extensionRegistry]];
    [registry addExtensions:[AppliedItemsRoot extensionRegistry]];
    [registry addExtensions:[EggIncubatorsRoot extensionRegistry]];
    [registry addExtensions:[CandyRoot extensionRegistry]];
    [registry addExtensions:[InventoryUpgradesRoot extensionRegistry]];
    [registry addExtensions:[PokemonDataRoot extensionRegistry]];
    [registry addExtensions:[PokedexEntryRoot extensionRegistry]];
    [registry addExtensions:[PlayerStatsRoot extensionRegistry]];
    [registry addExtensions:[PlayerCurrencyRoot extensionRegistry]];
    [registry addExtensions:[PlayerCameraRoot extensionRegistry]];
  }
  return registry;
}

@end

#pragma mark - InventoryItemDataRoot_FileDescriptor

static GPBFileDescriptor *InventoryItemDataRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPBDebugCheckRuntimeVersion();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"POGOProtos.Inventory"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - InventoryItemData

@implementation InventoryItemData

@dynamic hasPokemonData, pokemonData;
@dynamic hasItem, item;
@dynamic hasPokedexEntry, pokedexEntry;
@dynamic hasPlayerStats, playerStats;
@dynamic hasPlayerCurrency, playerCurrency;
@dynamic hasPlayerCamera, playerCamera;
@dynamic hasInventoryUpgrades, inventoryUpgrades;
@dynamic hasAppliedItems, appliedItems;
@dynamic hasEggIncubators, eggIncubators;
@dynamic hasCandy, candy;

typedef struct InventoryItemData__storage_ {
  uint32_t _has_storage_[1];
  PokemonData *pokemonData;
  ItemData *item;
  PokedexEntry *pokedexEntry;
  PlayerStats *playerStats;
  PlayerCurrency *playerCurrency;
  PlayerCamera *playerCamera;
  InventoryUpgrades *inventoryUpgrades;
  AppliedItems *appliedItems;
  EggIncubators *eggIncubators;
  Candy *candy;
} InventoryItemData__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "pokemonData",
        .dataTypeSpecific.className = GPBStringifySymbol(PokemonData),
        .number = InventoryItemData_FieldNumber_PokemonData,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(InventoryItemData__storage_, pokemonData),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "item",
        .dataTypeSpecific.className = GPBStringifySymbol(ItemData),
        .number = InventoryItemData_FieldNumber_Item,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(InventoryItemData__storage_, item),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "pokedexEntry",
        .dataTypeSpecific.className = GPBStringifySymbol(PokedexEntry),
        .number = InventoryItemData_FieldNumber_PokedexEntry,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(InventoryItemData__storage_, pokedexEntry),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "playerStats",
        .dataTypeSpecific.className = GPBStringifySymbol(PlayerStats),
        .number = InventoryItemData_FieldNumber_PlayerStats,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(InventoryItemData__storage_, playerStats),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "playerCurrency",
        .dataTypeSpecific.className = GPBStringifySymbol(PlayerCurrency),
        .number = InventoryItemData_FieldNumber_PlayerCurrency,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(InventoryItemData__storage_, playerCurrency),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "playerCamera",
        .dataTypeSpecific.className = GPBStringifySymbol(PlayerCamera),
        .number = InventoryItemData_FieldNumber_PlayerCamera,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(InventoryItemData__storage_, playerCamera),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "inventoryUpgrades",
        .dataTypeSpecific.className = GPBStringifySymbol(InventoryUpgrades),
        .number = InventoryItemData_FieldNumber_InventoryUpgrades,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(InventoryItemData__storage_, inventoryUpgrades),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "appliedItems",
        .dataTypeSpecific.className = GPBStringifySymbol(AppliedItems),
        .number = InventoryItemData_FieldNumber_AppliedItems,
        .hasIndex = 7,
        .offset = (uint32_t)offsetof(InventoryItemData__storage_, appliedItems),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "eggIncubators",
        .dataTypeSpecific.className = GPBStringifySymbol(EggIncubators),
        .number = InventoryItemData_FieldNumber_EggIncubators,
        .hasIndex = 8,
        .offset = (uint32_t)offsetof(InventoryItemData__storage_, eggIncubators),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "candy",
        .dataTypeSpecific.className = GPBStringifySymbol(Candy),
        .number = InventoryItemData_FieldNumber_Candy,
        .hasIndex = 9,
        .offset = (uint32_t)offsetof(InventoryItemData__storage_, candy),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[InventoryItemData class]
                                     rootClass:[InventoryItemDataRoot class]
                                          file:InventoryItemDataRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(InventoryItemData__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
