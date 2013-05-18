//
//  ServiceTermViewController.m
//  Emergency App
//
//  Created by Rafael Bento Cruz on 14/04/13.
//  Copyright (c) 2013 Rafael Bento Cruz. All rights reserved.
//

#import "ServiceTermViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ServiceTermViewController ()

@end

@implementation ServiceTermViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.tblService.layer removeAllAnimations];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* cellIdentifier = [NSString stringWithFormat:@"cellIdentifier"];
    
    UITableViewCell* cell;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
 
       
    UILabel* label = [[UILabel alloc]
                      initWithFrame:CGRectMake(5, 2, cell.bounds.size.width - 5, cell.bounds.size.height + 5)];
    
    [label clipsToBounds];
    label.numberOfLines = 0;
    label.textColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1];
    [label setFont:[UIFont systemFontOfSize:12]];
    
    

    switch (indexPath.section) {
        case 0:
        {
            label.text = @"O Emergency Response é um aplicativo de envio de mensagem de ajuda e só deve ser utilizado em casos reais de emergência.";
            break;
        }
        case 1:
        {
            label.text = @"O Emergency Response não efetua o envio de SMS nem publica conteúdo no Twitter© ou no Facebook© sem a solicitação e a confirmação do usuário";
            break;
        }
        case 2:
        {
            label.text = @"O usuário reconhece que é responsável pela mensagem enviada através deste aplicativo. O usuário isenta os desenvolvedores deste aplicativo de qualquer responsabilidade quanto à veracidade da mensagem e a utilização deste aplicativo.\rÉ de responsabilidade do usuário manter a lista de contatos sempre atualizada.";
            break;
        }
        case 3:
        {
            label.text = @"O Emergency Response utiliza o sinal da sua operadora de telefonia móvel para efetuar o envio do SMS e necessita de acesso a Internet seja através do pacote de dados do usuário ou de uma rede WI-FI para postar mensagens no Twitter© e Facebook©.\rOs desenvolvedores do Emergency Response não se responsabilizam pelo não envio do SMS ou publicação no Twitter© e Facebook© seja por falta de sinal da operadora, falta de conexão com a Internet, ou qualquer outra instabilidade momentânea que o telefone ou o aplicativo possa passar no momento da utilização.";
            break;
        }
        case 4:
        {
            label.text = @"É de responsabilidade do usuário manter o aplicativo conectado ao Twitter© e Facebook© se assim desejar. Lembre-se que ao alterar senhas e termos de uso em alguns destes serviços a permissão para publicar conteúdo no perfil do usuário dentro destes serviços através do Emergency Response poderá ser revogada. Caso isto ocorra e deverá ser feito uma nova solicitação de conexão através do aplicativo Emergency Response.";
            break;
        }
        case 5:
        {
            label.text = @"O Emergency Response é um aplicativo grátis tanto para adquirir quanto para utilizar. Mas ao enviar uma mensagem ou publicar no Twitter© e Facebook© por este aplicativo o usuário está ciente que estará utilizando os serviços de sua operadora de telefonia móvel e que isto poderá acarretar custos na sua sua fatura junto a operadora de telefonia móvel.";
            break;
        }
       
    }
    
    
    [label sizeToFit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.contentView addSubview:label];
    
    return cell;
    
}

#pragma mark UITableViewDelegate
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(7, 0, tableView.bounds.size.width, 0)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:232.0/255.0
                                                   green:232.0/255.0
                                                    blue:232.0/255.0
                                                   alpha:1.0]];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(7, 4, tableView.bounds.size.width, 13)];
    
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    
    switch (section) {
        case 0:
        {
            label.text = @"QUANDO UTILIZAR";
            break;
        }
        case 1:
        {
            label.text = @"PERMISSÃO PARA ENVIAR SMS E REDES SOCIAIS";
            break;
        }
        case 2:
        {
            label.text = @"CONTEÚDO DA MENSAGEM E LISTA DE CONTATO";
            break;
        }
        case 3:
        {
            label.text = @"QUALIDADE DO SINAL";
            break;
        }
        case 4:
        {
            label.text = @"CONEXÃO COM O TWITTER© e FACEBOOK©";
            break;
        }
        case 5:
        {
            label.text = @"CUSTO DE ENVIO E PUBLICAÇÃO";
            break;
        }
    }
    
    [headerView addSubview:label];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1)
        return 60;
    else if (indexPath.section == 2)
        return 120;
    else if (indexPath.section == 3)
        return 180;
    
    return 135;
}

@end
