:- use_module(library(pce)).
:- pce_image_directory('./images').
:- use_module(library(pce_style_item)).
:- dynamic color/2.

resource(img_principal, image, image('2.jpg')).
resource(inter, image, image('CCNI.jpg')).
resource(q1, image, image('3.jpg')).
resource(q2, image, image('envext.jpg')).
resource(q3, image, image('industry.jpg')).
resource(q4, image, image('literature.jpg')).
resource(q5, image, image('jez.jpg')).
resource(q6, image, image('literature.jpg')).
resource(q7, image, image('math.jpg')).
resource(q8, image, image('circonstance.jpg')).
resource(q9, image, image('svt.jpg')).
resource(q10, image, image('philo.jpg')).
resource(q11, image, image('artisanat.jpg')).
resource(q12, image, image('cuisine.jpg')).
resource(q13, image, image('design.jpg')).
resource(q14, image, image('agriculture.jpg')).
resource(q15, image, image('ingenierie.jpg')).


/*Ensemble des questions*/

question('Vous aimez tous ce qui est commerce et comptabilite?','q1').
question('Vous aimez les travaux manuels ou creatifs?','q2').
question('Vous aimez l''industrie mecanique/electrique?','q3').
question('vous etes bien en francais?','q4').
question('vous etes bien en anglais?','q5').
question('vous etes bien en espagnol?','q6').
question('vous etes bien en math/physique?','q7').
question('vous etes bien en arab et histoire geo?','q8').
question('vous etes bien en SVT?','q9').
question('vous etes bien en phylosophie?','q10').
question('vous etes passionne par l''artisanat?','q11').
question('vous aimez la cuisine?','q12').
question('vous aimez le design?','q13').
question('vous aimez l''agriculture?','q14').
question('Vous etes bien en sciences d''ingenieur?','q15').

/*Base de Faits:Ensemble des filieres et les questions vrai pour chaque filiere*/

tester('Tronc commun professionnel service',
['Vous aimez tous ce qui est commerce et comptabilite?']).

tester('Tronc commun professionnel service',
['Vous aimez les travaux manuels ou creatifs?',
'vous aimez la cuisine?']).

tester('Tronc commun professionnel service',
['Vous aimez les travaux manuels ou creatifs?',
'vous aimez le design?']).

tester('Tronc commun professionnel industriel',
['Vous aimez les travaux manuels ou creatifs?',
'Vous aimez l''industrie mecanique/electrique?']).

tester('Tronc commun professionnel industriel',
['Vous aimez les travaux manuels ou creatifs?',
'vous etes passionne par l''artisanat?']).

tester('Tronc commun professionnel agricole',
['Vous aimez les travaux manuels ou creatifs?',
'vous aimez l''agriculture?']).

tester('Tronc commun science internationale anglais',
['vous etes bien en anglais?',
'vous etes bien en math/physique?',
'vous etes bien en SVT?']).

tester('Tronc commun science internationale francais',
['vous etes bien en francais?',
'vous etes bien en math/physique?',
'vous etes bien en SVT?']).

tester('Tronc commun science internationale espagnol',
['vous etes bien en espagnol?',
'vous etes bien en math/physique?',
'vous etes bien en SVT?']).

tester('Tronc commun science',
['vous etes bien en math/physique?',
'vous etes bien en SVT?']).

tester('Tronc commun technique',
['vous etes bien en francais?',
'vous etes bien en math/physique?',
'Vous etes bien en sciences d''ingenieur?']).

tester('Tronc commun lettre et science humain internationale Anglais',
['vous etes bien en anglais?',
'vous etes bien en histoire geo?']).

tester('Tronc commun lettre et science humain internationale Anglais',
['vous etes bien en anglais?',
'vous etes bien en phylosophie?']).

tester('Tronc commun lettre et science humain internationale espagnol',
['vous etes bien en espagnol?',
'vous etes bien en histoire geo?']).

tester('Tronc commun lettre et science humain internationale Espagnol',
['vous etes bien en espagnol?',
'vous etes bien en phylosophie?']).

tester('Tronc commun lettre et science humain internationale francais',
['vous etes bien en francais?',
'vous etes bien en phylosophie?']).

tester('Tronc commun lettre et science humain internationale francais',
['vous etes bien en francais?',
'vous etes bien en histoire geo?']).

tester('Tronc commun lettre et science humain',
['vous etes bien en arab?',
'vous etes bien en phylosophie?']).

tester('Tronc commun lettre et science humain',
['vous etes bien en arab?',
'vous etes bien en histoire geo?']).

tester('autre',
[]).


/*Interface*/

affich-image(Affichage, Imagen) :-	new(Figure, figure),
                                    new(Bitmap, bitmap(resource(Imagen),@on)),
                                    send(Bitmap, name, 1),
                                    send(Figure, display, Bitmap),
                                    send(Figure, status, 1),
                                    send(Affichage, display,Figure,point(100,80)).

nouv_imagen(Fenetre, Imagen) :-	new(Figure, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figure, display, Bitmap),
                                send(Figure, status, 1),
                                send(Fenetre, display,Figure,point(0,0)).
imagen_quest(Fenetre, Imagen):-	new(Figure, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figure, display, Bitmap),
                                send(Figure, status, 1),
                                send(Fenetre, display,Figure,point(500,60)).

boutons:-	effacer,
			send(@debut, free),
            send(@btntraitement,free),predicat(Metier),
            send(@texto, selection('vous propose de choisir:')),
            send(@resp1, selection(Metier)),
			new(@debut, button('RECOMMENCER',message(@prolog, boutons))),
			new(@btntraitement,button('¿traiter?')),
			send(@main, display,@debut,point(175,450)).

traiter(X):- send(@lblExp1,selection('vous propose de choisir:')),
                 affich-image-traitement(@tratam,X).

demander(Preg,Resp) :-	new(Di,dialog('Questions:')),
                        new(L2,label(texto,'Repondez aux Questions')),
                        question(Preg,Imagen),
                        imagen_quest(Di,Imagen),
                        new(La,label(prob,Preg)),
                        new(B1,button(oui,and(message(Di,return,oui)))),
                        new(B2,button(non,and(message(Di,return,non)))),
                        send(Di, gap, size(22,25)),
                        send(Di,append(L2)),
                        send(Di,append(La)),
                        send(Di,append(B1)),
                        send(Di,append(B2)),
                        send(Di,default_button,'oui'),
                        send(Di,open_centered),get(Di,confirm,Reponse),
                        free(Di),
                        Resp=Reponse.

interface_principal :-	new(@main,dialog('System de reflexion de filiere qui vous convient',size(1000,1000))),
						new(@texto, label(nombre,'vous propose de choisir:',font('georgia','roman',18))),
						new(@texto2, label(nombre,'comme ton filiere.',font('georgia','roman',18))),
						new(@resp1, label(nombre,'',font('georgia','roman',18))),
						new(@lblExp1, label(nombre,'',font('georgia','roman',14))),
						new(@lblExp2, label(nombre,'',font('georgia','roman',14))),
						new(@quitter,button('QUITTER',and(message(@main,destroy),message(@main,free)))),
						new(@debut, button('COMMENCER LE TEST',message(@prolog, boutons))),
						new(@btntraitement,button('¿traiter?')),
						nouv_imagen(@main, img_principal),
						send(@main, display,@debut,point(138,450)),
						send(@main, display,@texto,point(57,185)),
						send(@main, display,@texto2,point(57,255)),
						send(@main, display,@quitter,point(300,450)),
						send(@main, display,@resp1,point(57,220)),
						send(@main,open_centered).

effacer :-	send(@resp1, selection('')).

creer_interface :-	new(@interface,dialog('Bienvenue dans votre application OrienTest',size(1000,1000))),
					affich-image(@interface, inter),
					new(BoutonComencer,button('COMMENCER',and(message(@prolog,interface_principal),and(message(@interface,destroy),message(@interface,free))))),
					new(Bouton,button('QUITTER',and(message(@interface,destroy),message(@interface,free)))),
					send(@interface,append(BoutonComencer)),
					send(@interface,append(Bouton)),
					send(@interface,open_centered).

:-creer_interface.

/*Moteur d inference:Cette partie du System a pour but de deviner la filiere qui convient a partir des reponse des questions posés*/

:- dynamic connexion/1.

predicat(X) :- a_filier(X),clean_scratchpad.

predicat(introuvable) :- clean_scratchpad .

a_filier(Metiercherch) :- hypothese_correcte(Metiercherch, ListeCorrecte),
                          trouverounn(Metiercherch, ListeCorrecte).

hypothese_correcte(Metiercherch, ListeCorrecte)	:- tester(Metiercherch, ListeCorrecte).

trouverounn(Metiercherch, []).
trouverounn(Metiercherch, [Head | Tail]) :- chercher_filier(Metiercherch, Head),
                                            trouverounn(Metiercherch, Tail).

chercher_filier(Metiercherch, Correcte):- connexion(Correcte).
chercher_filier(Metiercherch, Correcte):- not(connexion(is_false(Correcte))),
question_cherch(Metiercherch, Correcte, Reply), Reply = 'oui'.

question_cherch(Metiercherch, Correcte, Reply) :- demander(Correcte,Resp),
                                                  process(Metiercherch, Correcte, Resp, Reply).

process(Metiercherch, Correcte, oui, oui):- asserta(connexion(Correcte)).
process(Metiercherch, Correcte, non, non):- asserta(connexion(is_false(Correcte))).

clean_scratchpad:- retract(connexion(X)), fail.
clean_scratchpad.

connexion(_):- fail.
not(X):- X,!,fail.
not(_).
