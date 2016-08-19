//
//  PGResponseBuilder.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-18.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGResponseBuilder.h"
#import "RequestEnvelope.pbobjc.h"
#import "AuthTicket.pbobjc.h"
#import "Request.pbobjc.h"

@interface PGResponseBuilder ()
@property (nonatomic, strong) NSMutableOrderedSet *responseClasses;
@end

@implementation PGResponseBuilder

- (Class)getResponseClassForRequestType:(RequestType)type {
    switch (type) {
        case RequestType_PlayerUpdate:
            return [PlayerUpdateResponse class];
        case RequestType_GetPlayer:
            return [GetPlayerResponse class];
        case RequestType_GetInventory:
            return [GetInventoryResponse class];
        case RequestType_DownloadSettings:
            return [DownloadSettingsResponse class];
        case RequestType_DownloadItemTemplates:
            return [DownloadItemTemplatesResponse class];
        case RequestType_DownloadRemoteConfigVersion:
            return [DownloadRemoteConfigVersionResponse class];
        case RequestType_FortSearch:
            return [FortSearchResponse class];
        case RequestType_Encounter:
            return [EncounterResponse class];
        case RequestType_CatchPokemon:
            return [CatchPokemonResponse class];
        case RequestType_FortDetails:
            return [FortDetailsResponse class];
        case RequestType_GetMapObjects:
            return [GetMapObjectsResponse class];
        case RequestType_FortDeployPokemon:
            return [FortDeployPokemonResponse class];
        case RequestType_FortRecallPokemon:
            return [FortRecallPokemonResponse class];
        case RequestType_ReleasePokemon:
            return [ReleasePokemonResponse class];
        case RequestType_UseItemPotion:
            return [UseItemPotionResponse class];
        case RequestType_UseItemCapture:
            return [UseItemCaptureResponse class];
        case RequestType_UseItemRevive:
            return [UseItemReviveResponse class];
        case RequestType_GetPlayerProfile:
            return [GetPlayerProfileResponse class];
        case RequestType_EvolvePokemon:
            return [EvolvePokemonResponse class];
        case RequestType_GetHatchedEggs:
            return [GetHatchedEggsResponse class];
        case RequestType_EncounterTutorialComplete:
            return [EncounterTutorialCompleteResponse class];
        case RequestType_LevelUpRewards:
            return [LevelUpRewardsResponse class];
        case RequestType_CheckAwardedBadges:
            return [CheckAwardedBadgesResponse class];
        case RequestType_GetGymDetails:
            return [GetGymDetailsResponse class];
        case RequestType_StartGymBattle:
            return [StartGymBattleResponse class];
        case RequestType_AttackGym:
            return [AttackGymResponse class];
        case RequestType_RecycleInventoryItem:
            return [RecycleInventoryItemResponse class];
        case RequestType_CollectDailyBonus:
            return [CollectDailyBonusResponse class];
        case RequestType_UseItemXpBoost:
            return [UseItemXpBoostResponse class];
        case RequestType_UseItemEggIncubator:
            return [UseItemEggIncubatorResponse class];
        case RequestType_UseIncense:
            return [UseIncenseResponse class];
        case RequestType_GetIncensePokemon:
            return [GetIncensePokemonResponse class];
        case RequestType_IncenseEncounter:
            return [IncenseEncounterResponse class];
        case RequestType_AddFortModifier:
            return [AddFortModifierResponse class];
        case RequestType_DiskEncounter:
            return [DiskEncounterResponse class];
        case RequestType_CollectDailyDefenderBonus:
            return [CollectDailyDefenderBonusResponse class];
        case RequestType_UpgradePokemon:
            return [UpgradePokemonResponse class];
        case RequestType_SetFavoritePokemon:
            return [SetFavoritePokemonResponse class];
        case RequestType_NicknamePokemon:
            return [NicknamePokemonResponse class];
        case RequestType_EquipBadge:
            return [EquipBadgeResponse class];
        case RequestType_GetAssetDigest:
            return [GetAssetDigestResponse class];
        case RequestType_GetDownloadUrls:
            return [GetDownloadUrlsResponse class];
        case RequestType_GetSuggestedCodenames:
            return [GetSuggestedCodenamesResponse class];
        case RequestType_CheckCodenameAvailable:
            return [CheckCodenameAvailableResponse class];
        case RequestType_ClaimCodename:
            return [ClaimCodenameResponse class];
        case RequestType_SetAvatar:
            return [SetAvatarResponse class];
        case RequestType_SetPlayerTeam:
            return [SetPlayerTeamResponse class];
        case RequestType_MarkTutorialComplete:
            return [MarkTutorialCompleteResponse class];
        case RequestType_Echo:
            return [EchoResponse class];
        case RequestType_SfidaActionLog:
            return [SfidaActionLogResponse class];
        case RequestType_UseItemGym:
            return [UseItemGymResponse class];
        case RequestType_SetContactSettings:
            return [SetContactSettingsResponse class];
        case RequestType_ItemUse:
        case RequestType_UseItemFlee:
        case RequestType_TradeSearch:
        case RequestType_TradeOffer:
        case RequestType_TradeResponse:
        case RequestType_TradeResult:
        case RequestType_GetItemPack:
        case RequestType_BuyItemPack:
        case RequestType_BuyGemPack:
        case RequestType_LoadSpawnPoints:
        case RequestType_DebugUpdateInventory:
        case RequestType_DebugDeletePlayer:
        case RequestType_SfidaRegistration:
        case RequestType_SfidaCertification:
        case RequestType_SfidaUpdate:
        case RequestType_SfidaDowser:
        case RequestType_SfidaAction:
        case RequestType_SfidaCapture:
            NSAssert1(NO, @"Unsupported request type:%i", type);
            return nil;
        case RequestType_MethodUnset:
        case RequestType_GPBUnrecognizedEnumeratorValue:
            NSAssert1(NO, @"Invalid request type:%i", type);
            return nil;
    }
}

- (instancetype)init {
    if (self = [super init]) {
        self.responseClasses = [NSMutableOrderedSet orderedSet];
    }
    return self;
}

- (void)addRequestType:(RequestType)type {
    Class responseClass = [self getResponseClassForRequestType:type];
    NSAssert(![self.responseClasses containsObject:responseClass], @"A request group can not contain duplicate requests.");
    [self.responseClasses addObject:responseClass];
}

- (NSArray *)buildFromEnvelope:(ResponseEnvelope *)envelope {
    NSMutableArray *responses = [NSMutableArray arrayWithCapacity:self.responseClasses.count];
    for (int i = 0; i < envelope.returnsArray_Count; i++) {
        NSData *data = [envelope.returnsArray objectAtIndex:i];
        Class responseClass = [self.responseClasses objectAtIndex:i];
        
        NSError *error;
        GPBMessage *message = [responseClass parseFromData:data error:&error];
        PGResponse *response = [[PGResponse alloc] initWithMessage:message error:error];
        [responses addObject:response];
    }
    return responses;
}


@end
