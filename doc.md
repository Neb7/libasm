# Les "Variables" en Assembleur (x86/x86-64)

En assembleur, il n'existe pas de "variables" au sens des langages de haut niveau.
On distingue en réalité **trois catégories** :

1. Les **registres** (mémoire ultra-rapide du processeur)
2. Les **variables mémoire** (déclarées via des directives dans la section `.data`)
3. Les **registres spéciaux** (pointeurs, index, drapeaux)

---

## 1. Les registres généraux (32 bits - x86)

| Registre 32 bits | Registre 16 bits | Registre 8 bits (haut) | Registre 8 bits (bas) | Rôle habituel |
|---|---|---|---|---|
| EAX | AX | AH | AL | Accumulateur (calculs, valeur de retour) |
| EBX | BX | BH | BL | Base (adressage mémoire) |
| ECX | CX | CH | CL | Compteur (boucles) |
| EDX | DX | DH | DL | Données (extension pour multiplications/divisions) |

> En 64 bits, ces registres deviennent `RAX`, `RBX`, `RCX`, `RDX`, etc.

---

## 1bis. Les registres généraux (64 bits - x86-64)

| Registre 64 bits | Registre 32 bits | Registre 16 bits | Registre 8 bits | Rôle habituel |
|---|---|---|---|---|
| RAX | EAX | AX | AL | Accumulateur / valeur de retour |
| RBX | EBX | BX | BL | Base |
| RCX | ECX | CX | CL | Compteur (boucles) / 4eme Arguments|
| RDX | EDX | DX | DL | Données / 3eme Arguments|
| RSI | ESI | SI | SIL | Source Index (pointeur source) / 2eme Arguments|
| RDI | EDI | DI | DIL | Destination Index (pointeur destination) / 1er Arguments|
| RBP | EBP | BP | BPL | Base Pointer (base de la pile) |
| RSP | ESP | SP | SPL | Stack Pointer (sommet de la pile) |
| R8 | R8D | R8W | R8B | Registre supplémentaire (arg. 5 en convention System V) |
| R9 | R9D | R9W | R9B | Registre supplémentaire (arg. 6 en convention System V) |
| R10 | R10D | R10W | R10B | Registre supplémentaire (temporaire) |
| R11 | R11D | R11W | R11B | Registre supplémentaire (temporaire) |
| R12 | R12D | R12W | R12B | Registre supplémentaire (callee-saved) |
| R13 | R13D | R13W | R13B | Registre supplémentaire (callee-saved) |
| R14 | R14D | R14W | R14B | Registre supplémentaire (callee-saved) |
| R15 | R15D | R15W | R15B | Registre supplémentaire (callee-saved) |
| RIP | EIP | IP | — | Instruction Pointer |

> **Note :** en x86-64, `R8`–`R15` sont des registres additionnels qui n'existent pas en 32 bits. Sur Linux (convention d'appel *System V AMD64*), les 6 premiers arguments d'une fonction passent dans `RDI, RSI, RDX, RCX, R8, R9`.

### Arguments de fonction sur Linux x86-64 (System V AMD64)

| Ordre de l'argument | Registre |
|---|---|
| 1er | RDI |
| 2e | RSI |
| 3e | RDX |
| 4e | RCX |
| 5e | R8 |
| 6e | R9 |

Les arguments suivants sont placés sur la pile. Le registre `RAX` sert souvent pour la valeur de retour.

> En x86 32 bits, les arguments sont généralement passés sur la pile, pas dans des registres.

---

## 2. Les registres d'index et pointeurs (32 bits)

| Registre | Nom complet | Rôle |
|---|---|---|
| ESI / RSI | Source Index | Pointeur source (copies de chaînes) |
| EDI / RDI | Destination Index | Pointeur destination |
| EBP / RBP | Base Pointer | Base de la pile (accès aux variables locales) |
| ESP / RSP | Stack Pointer | Sommet de la pile |
| EIP / RIP | Instruction Pointer | Adresse de la prochaine instruction (non manipulable directement) |

---

## 3. Le registre de drapeaux (FLAGS)

| Bit / Flag | Nom | Signification |
|---|---|---|
| ZF | Zero Flag | Résultat = 0 |
| CF | Carry Flag | Retenue lors d'une opération |
| SF | Sign Flag | Résultat négatif |
| OF | Overflow Flag | Dépassement de capacité signé |
| PF | Parity Flag | Parité du résultat |

---

## 4. Déclaration de "variables" mémoire (section `.data`)

En assembleur, une "variable" est en réalité un **emplacement mémoire nommé** (une étiquette / *label*) réservé grâce à une directive.

### Directives de déclaration (NASM)

| Directive | Taille | Exemple |
|---|---|---|
| `DB` | 1 octet (Byte) | `valeur DB 10` |
| `DW` | 2 octets (Word) | `valeur DW 1000` |
| `DD` | 4 octets (Double Word) | `valeur DD 100000` |
| `DQ` | 8 octets (Quad Word) | `valeur DQ 123456789` |
| `DT` | 10 octets (Ten bytes) | `valeur DT 0` |

### Réservation sans initialisation (section `.bss`)

| Directive | Taille | Exemple |
|---|---|---|
| `RESB` | 1 octet | `buffer RESB 64` |
| `RESW` | 2 octets | `tampon RESW 10` |
| `RESD` | 4 octets | `entier RESD 1` |
| `RESQ` | 8 octets | `grand RESQ 1` |

### Exemple complet

```asm
section .data
    message   db  "Bonjour", 0     ; chaîne de caractères
    valeur    dw  1234             ; entier 16 bits
    total     dd  0                ; entier 32 bits initialisé à 0

section .bss
    resultat  resd 1               ; réserve 4 octets non initialisés
```

---

## 5. Les constantes (via `EQU`)

`EQU` permet de définir une constante symbolique (substituée à la compilation, ne réserve pas de mémoire) :

```asm
TAILLE equ 100
```

---

## 6. Modes d'adressage (comment on "accède" à une variable)

| Mode | Exemple | Description |
|---|---|---|
| Immédiat | `mov eax, 5` | Valeur directe |
| Direct (registre) | `mov eax, ebx` | Copie de registre à registre |
| Direct (mémoire) | `mov eax, [valeur]` | Lecture d'une variable mémoire |
| Indirect | `mov eax, [ebx]` | Adresse contenue dans un registre |
| Indexé | `mov eax, [ebx + esi]` | Base + index |
| Base + déplacement | `mov eax, [ebp - 4]` | Variable locale sur la pile |

---

## 7. Les instructions / méthodes courantes

| Instruction | Rôle | Exemple | Effet |
|---|---|---|---|
| `mov` | Copier une valeur | `mov rax, rbx` | Copie une donnée sans la modifier |
| `movzx` | Copier avec extension zéro | `movzx eax, byte [rdi]` | Lit un petit type et complète avec des `0` |
| `xor` | Opération logique XOR | `xor eax, eax` | Met souvent un registre à `0` rapidement |
| `cmp` | Comparer deux valeurs | `cmp cl, [rsi]` | Met à jour les drapeaux sans stocker le résultat |
| `test` | Tester des bits | `test cl, cl` | Sert souvent à vérifier si une valeur vaut `0` |
| `jne` | Saut si différent | `jne .diff` | Saute si le drapeau `ZF` vaut `0` |
| `je` | Saut si égal | `je .equal` | Saute si le drapeau `ZF` vaut `1` |
| `jc` | Saut si retenue | `jc .carry` | Saute si le drapeau `CF` vaut `1` |
| `js` | Saut si signe | `js .negative` | Saute si le drapeau `SF` vaut `1` |
| `inc` | Incrémenter | `inc rax` | Ajoute `1` au registre |
| `jmp` | Saut inconditionnel | `jmp .loop` | Va directement à une autre instruction |
| `sub` | Soustraire | `sub eax, ecx` | Calcule une différence |
| `ret` | Retour de fonction | `ret` | Revient à l’appelant |

### Les sauts conditionnels les plus courants

| Instruction | Alias | Condition | Sens |
|---|---|---|---|
| `jmp` | — | toujours | Saut inconditionnel |
| `je` | `jz` | `ZF = 1` | égal |
| `jne` | `jnz` | `ZF = 0` | différent |
| `jc` | `jb`, `jnae` | `CF = 1` | retenue / inférieur non signé |
| `jnc` | `jae`, `jnb` | `CF = 0` | pas de retenue / supérieur ou égal non signé |
| `ja` | `jnbe` | `CF = 0` et `ZF = 0` | strictement supérieur non signé |
| `jbe` | `jna` | `CF = 1` ou `ZF = 1` | inférieur ou égal non signé |
| `js` | — | `SF = 1` | signe négatif |
| `jns` | — | `SF = 0` | signe positif ou nul |
| `jo` | — | `OF = 1` | overflow |
| `jno` | — | `OF = 0` | pas d'overflow |
| `jp` | `jpe` | `PF = 1` | parité paire |
| `jnp` | `jpo` | `PF = 0` | parité impaire |
| `jl` | `jnge` | `SF != OF` | inférieur signé |
| `jge` | `jnl` | `SF = OF` | supérieur ou égal signé |
| `jle` | `jng` | `ZF = 1` ou `SF != OF` | inférieur ou égal signé |
| `jg` | `jnle` | `ZF = 0` et `SF = OF` | strictement supérieur signé |
| `jcxz` | `jecxz`, `jrcxz` | `CX/ECX/RCX = 0` | saute si le compteur est nul |

Les alias sont souvent équivalents au même test, seul le nom change selon la lecture qu'on veut donner à la comparaison.

> Pour les comparaisons non signées, on lit surtout `CF` et `ZF`. Pour les comparaisons signées, on lit surtout `SF` et `OF`.

### Les instructions de boucle liées aux sauts

| Instruction | Alias | Principe | Sens |
|---|---|---|---|
| `loop` | — | décrémente `CX/ECX/RCX`, saute si le compteur n'est pas nul | boucle simple |
| `loope` | `loopz` | décrémente puis saute si le compteur n'est pas nul et `ZF = 1` | boucle tant qu'égal |
| `loopne` | `loopnz` | décrémente puis saute si le compteur n'est pas nul et `ZF = 0` | boucle tant qu'inégal |

Ces instructions sont pratiques pour les petites boucles, mais on utilise souvent `cmp` + `je/jne` ou `dec` + `jnz` pour plus de contrôle.

---

## Résumé visuel

```
┌─────────────────────────────┐
│  "VARIABLES" EN ASSEMBLEUR  │
├─────────────────────────────┤
│ 1. Registres (EAX, EBX...)  │  → rapides, taille fixe
│ 2. Mémoire (.data / .bss)   │  → DB, DW, DD, DQ, RESB...
│ 3. Constantes (EQU)         │  → pas de mémoire réservée
│ 4. Pile (EBP - offset)      │  → variables locales
└─────────────────────────────┘
```