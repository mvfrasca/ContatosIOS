//
//  Contato.m
//  ContatosIP67
//
//  Created by ios7126 on 12/09/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

-(NSString *)description {
    return [NSString stringWithFormat:@"Nome: %@, Telefone: %@, Endereço: %@, Site: %@", self.nome, self.telefone, self.endereco, self.site];
}

@end
