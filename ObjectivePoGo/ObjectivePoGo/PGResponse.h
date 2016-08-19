//
//  PGResponse.h
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-18.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseEnvelope.pbobjc.h"

#import "AddFortModifierResponse.pbobjc.h"
#import "AttackGymResponse.pbobjc.h"
#import "CatchPokemonResponse.pbobjc.h"
#import "CheckAwardedBadgesResponse.pbobjc.h"
#import "CheckCodenameAvailableResponse.pbobjc.h"
#import "ClaimCodenameResponse.pbobjc.h"
#import "CollectDailyBonusResponse.pbobjc.h"
#import "CollectDailyDefenderBonusResponse.pbobjc.h"
#import "DiskEncounterResponse.pbobjc.h"
#import "DownloadItemTemplatesResponse.pbobjc.h"
#import "DownloadRemoteConfigVersionResponse.pbobjc.h"
#import "DownloadSettingsResponse.pbobjc.h"
#import "EchoResponse.pbobjc.h"
#import "EncounterResponse.pbobjc.h"
#import "EncounterTutorialCompleteResponse.pbobjc.h"
#import "EquipBadgeResponse.pbobjc.h"
#import "EvolvePokemonResponse.pbobjc.h"
#import "FortDeployPokemonResponse.pbobjc.h"
#import "FortDetailsResponse.pbobjc.h"
#import "FortRecallPokemonResponse.pbobjc.h"
#import "FortSearchResponse.pbobjc.h"
#import "GetAssetDigestResponse.pbobjc.h"
#import "GetDownloadUrlsResponse.pbobjc.h"
#import "GetGymDetailsResponse.pbobjc.h"
#import "GetHatchedEggsResponse.pbobjc.h"
#import "GetIncensePokemonResponse.pbobjc.h"
#import "GetInventoryResponse.pbobjc.h"
#import "GetMapObjectsResponse.pbobjc.h"
#import "GetPlayerResponse.pbobjc.h"
#import "GetPlayerProfileResponse.pbobjc.h"
#import "GetSuggestedCodenamesResponse.pbobjc.h"
#import "IncenseEncounterResponse.pbobjc.h"
#import "LevelUpRewardsResponse.pbobjc.h"
#import "MarkTutorialCompleteResponse.pbobjc.h"
#import "NicknamePokemonResponse.pbobjc.h"
#import "PlayerUpdateResponse.pbobjc.h"
#import "RecycleInventoryItemResponse.pbobjc.h"
#import "ReleasePokemonResponse.pbobjc.h"
#import "SetAvatarResponse.pbobjc.h"
#import "SetContactSettingsResponse.pbobjc.h"
#import "SetFavoritePokemonResponse.pbobjc.h"
#import "SetPlayerTeamResponse.pbobjc.h"
#import "SfidaActionLogResponse.pbobjc.h"
#import "StartGymBattleResponse.pbobjc.h"
#import "UpgradePokemonResponse.pbobjc.h"
#import "UseIncenseResponse.pbobjc.h"
#import "UseItemCaptureResponse.pbobjc.h"
#import "UseItemEggIncubatorResponse.pbobjc.h"
#import "UseItemGymResponse.pbobjc.h"
#import "UseItemPotionResponse.pbobjc.h"
#import "UseItemReviveResponse.pbobjc.h"
#import "UseItemXpBoostResponse.pbobjc.h"

@interface PGResponse : NSObject
@property (readonly, nonatomic, strong) GPBMessage *message;
@property (readonly, nonatomic, strong) NSError *error;
- (instancetype)initWithMessage:(GPBMessage *)message error:(NSError *)error;
@end
