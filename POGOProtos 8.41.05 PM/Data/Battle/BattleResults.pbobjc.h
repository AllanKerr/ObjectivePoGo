// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: POGOProtos/Data/Battle/BattleResults.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_GEN_VERSION != 30001
#error This file was generated by a different version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class BattleParticipant;
@class GymState;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - BattleResultsRoot

/// Exposes the extension registry for this file.
///
/// The base class provides:
/// @code
///   + (GPBExtensionRegistry *)extensionRegistry;
/// @endcode
/// which is a @c GPBExtensionRegistry that includes all the extensions defined by
/// this file and all files that it depends on.
@interface BattleResultsRoot : GPBRootObject
@end

#pragma mark - BattleResults

typedef GPB_ENUM(BattleResults_FieldNumber) {
  BattleResults_FieldNumber_GymState = 1,
  BattleResults_FieldNumber_AttackersArray = 2,
  BattleResults_FieldNumber_PlayerExperienceAwardedArray = 3,
  BattleResults_FieldNumber_NextDefenderPokemonId = 4,
  BattleResults_FieldNumber_GymPointsDelta = 5,
};

@interface BattleResults : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) GymState *gymState;
/// Test to see if @c gymState has been set.
@property(nonatomic, readwrite) BOOL hasGymState;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<BattleParticipant*> *attackersArray;
/// The number of items in @c attackersArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger attackersArray_Count;

@property(nonatomic, readwrite, strong, null_resettable) GPBInt32Array *playerExperienceAwardedArray;
/// The number of items in @c playerExperienceAwardedArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger playerExperienceAwardedArray_Count;

@property(nonatomic, readwrite) int64_t nextDefenderPokemonId;

@property(nonatomic, readwrite) int32_t gymPointsDelta;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
