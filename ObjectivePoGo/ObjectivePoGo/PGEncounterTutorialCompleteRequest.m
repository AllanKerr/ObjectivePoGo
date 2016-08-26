//
//  PGEncounterTutorialCompleteRequest.m
//  ObjectivePoGo
//
//  Created by 43f9879ddabcb80a685cf0e269a0bfca1e52786dee41c38604ae3b28a9d53657 on 2016-08-26.
//  Copyright © 2016 f6da75852aea28f8213466482daa395c113ec503406009dcaf1659e8139d4e56. All rights reserved.
//

#import "PGEncounterTutorialCompleteRequest.h"
#import "EncounterTutorialCompleteMessage.pbobjc.h"
#import "PokemonId.pbobjc.h"

@implementation PGEncounterTutorialCompleteRequest

- (instancetype)init {
    if (self = [super initWithType:RequestType_EncounterTutorialComplete]) {
        EncounterTutorialCompleteMessage *message = [EncounterTutorialCompleteMessage message];
        int type = arc4random() % 3;
        if (type == 0) {
            message.pokemonId = PokemonId_Squirtle;
        } else if (type == 1) {
            message.pokemonId = PokemonId_Charmander;
        } else {
            message.pokemonId = PokemonId_Bulbasaur;
        }
        self.rawRequest.requestMessage = message.data;
    }
    return self;
}

@end
