#Requires AutoHotkey v2.0

/* ENGLUSH LOREM IPSUM GENERATOR */
en_sentences := [
    "But I must explain to you how all this mistaken idea of reprobating pleasure and extolling pain arose.",
    "To do so, I will give you a complete account of the system, and expound the actual teachings of the great explorer of truth, the master-builder of human happiness.",
    "No one rejects, dislikes or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful.",
    "Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure.",
    "To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it?",
    "But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?",
    "On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of the pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain.",
    "These cases are perfectly simple and easy to distinguish.",
    "In a free hour, when our power of choice is untrammeled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided.",
    "But in certain emergencies and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted.",
    "The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.",
    "This being the theory I hold, why need I be afraid of not being able to reconcile it with the case of my ancestors?",
    "Your references to them just now were historically correct, and also showed your kind and friendly feeling towards myself; but all the same I am not to be bribed by your flattery of my family, and you will not find me a less resolute opponent.",
    "Tell me, pray, what explanation do you put upon their actions?",
    "Do you really believe that they charged an armed enemy, or treated their children, their own flesh and blood, so cruelly, without a thought for their own interest or advantage?",
    "Why, even wild animals do not act in that way; they do not run amok so blindly that we cannot discern any purpose in their movements and their onslaughts.",
    "Can you then suppose that those heroic men performed their famous deeds without any motive at all?"
]

random_sentence() {
    ; Random sentence from the list
    return en_sentences[Random(1, en_sentences.Length)]
}

random_paragraph() {
    ; Generate random paragraph from the list of sentences

    par := ""

    Loop Random(2,5) {
        par := par random_sentence() " "
    } 

    return par
}

/* Generate random sentences */

::elorem;;:: {
    ; Generate a random sentence
    Send random_sentence()
    return
}

::2elorem;;:: {
    ; Generate 2 random sentences

    Loop 2 {
        Send random_sentence() " "
    }
    return
}

::3elorem;;:: {
    ; Generate 3 random sentences

    Loop 3 {
        Send random_sentence() " "
    }
    return
}

::4elorem;;:: {
    ; Generate 4 random sentences

    Loop 4 {
        Send random_sentence() " "
    }
    return
}

/* Generate random paragraphs */

::elorem..:: {
    ; Generate a random paragraph

    Send random_paragraph()
    return
}

::2elorem..:: {
    ; Generate 2 random paragraphs

    Loop 2 {
        Send random_paragraph() "{Enter 2}"
    }
    return
}

::3elorem..:: {
    ; Generate 3 random paragraphs

    Loop 3 {
        Send random_paragraph() "{Enter 2}"
    }
    return
}

::4elorem..:: {
    ; Generate 4 random paragraphs

    Loop 4 {
        Send random_paragraph() "{Enter 2}"
    }
    return
}

; ============================================================================

/* LATIN LOREM IPSUM GENERATOR */

ln_sentences := [
    "Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.",
    "Curabitur blandit tempus ardua ridiculus sed magna.",
    "Inmensae subtilitatis, obscuris et malesuada fames.",
    "Paullum deliquit, ponderibus modulisque suis ratio utitur.",
    "Pellentesque habitant morbi tristique senectus et netus.",
    "A communi observantia non est recedendum.",
    "Unam incolunt Belgae, aliam Aquitani, tertiam.",
    "Magna pars studiorum, prodita quaerimus.",
    "Gallia est omnis divisa in partes tres, quarum.",
    "Phasellus laoreet lorem vel dolor tempus vehicula.",
    "Cras mattis iudicium purus sit amet fermentum.",
    "Nec dubitamus multa iter quae et nos invenerat.",
    "Quo usque tandem abutere, Catilina, patientia nostra?",
    "Curabitur est gravida et libero vitae dictum.",
    "Quisque ut dolor gravida, placerat libero vel, euismod.",
    "Ullamco laboris nisi ut aliquid ex ea commodi consequat."
]

random_lnsentence() {
    ; Random sentence from the list
    return ln_sentences[Random(1, ln_sentences.Length)]
}

random_lnparagraph() {
    ; Generate random paragraph from the list of sentences

    par := ""

    Loop Random(3,7) {
        par := par random_lnsentence() " "
    } 

    return par
}

/* Generate random sentences */

::lorem;;:: {
    ; Generate a random sentence
    Send random_lnsentence()
    return
}

::2lorem;;:: {
    ; Generate 2 random sentences

    Loop 2 {
        Send random_lnsentence() " "
    }
    return
}

::3lorem;;:: {
    ; Generate 3 random sentences

    Loop 3 {
        Send random_lnsentence() " "
    }
    return
}

::4lorem;;:: {
    ; Generate 4 random sentences

    Loop 4 {
        Send random_lnsentence() " "
    }
    return
}

/* Generate random paragraphs */

::lorem..:: {
    ; Generate a random paragraph

    Send random_lnparagraph()
    return
}

::2lorem..:: {
    ; Generate 2 random paragraphs

    Loop 2 {
        Send random_lnparagraph() "{Enter 2}"
    }
    return
}

::3lorem..:: {
    ; Generate 3 random paragraphs

    Loop 3 {
        Send random_lnparagraph() "{Enter 2}"
    }
    return
}

::4lorem..:: {
    ; Generate 4 random paragraphs

    Loop 4 {
        Send random_lnparagraph() "{Enter 2}"
    }
    return
}