// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: POGOProtos/Networking/Requests/Messages/GetPlayerMessage.proto

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

@class GetPlayerMessage_PlayerLocale;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - GetPlayerMessageRoot

/// Exposes the extension registry for this file.
///
/// The base class provides:
/// @code
///   + (GPBExtensionRegistry *)extensionRegistry;
/// @endcode
/// which is a @c GPBExtensionRegistry that includes all the extensions defined by
/// this file and all files that it depends on.
@interface GetPlayerMessageRoot : GPBRootObject
@end

#pragma mark - GetPlayerMessage

typedef GPB_ENUM(GetPlayerMessage_FieldNumber) {
  GetPlayerMessage_FieldNumber_PlayerLocale = 1,
};

@interface GetPlayerMessage : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) GetPlayerMessage_PlayerLocale *playerLocale;
/// Test to see if @c playerLocale has been set.
@property(nonatomic, readwrite) BOOL hasPlayerLocale;

@end

#pragma mark - GetPlayerMessage_PlayerLocale

typedef GPB_ENUM(GetPlayerMessage_PlayerLocale_FieldNumber) {
  GetPlayerMessage_PlayerLocale_FieldNumber_Country = 1,
  GetPlayerMessage_PlayerLocale_FieldNumber_Language = 2,
};

@interface GetPlayerMessage_PlayerLocale : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *country;

@property(nonatomic, readwrite, copy, null_resettable) NSString *language;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
