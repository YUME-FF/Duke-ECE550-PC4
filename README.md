# ECE550-PC4

## Development Objective

### Opcode
| Instruction  | Opcode |
| ------------- | ------------- |
| R-type  | 00000  |
| Addi  | 01000  |
| Sw  | 01011  |
| Lw  | 00011  |
### Control Circuits
| Control Singal  | Decode |
| ------------- | ------------- |
| Rwe  | Rtype + Addi + Lw  |
| Rdst  | Rtype  |
| ALUinB  | Addi + Lw + Sw  |
| ALUop  | Beq(Not in this checkpoint)  |
| BR  | Beq(Not in this checkpoint)  |
| DMwe  | Sw  |
| JP  | J(Not in this checkpoint)  |
| Rwd  | Lw  |

## Progess


## Issue Tracker


## Cautions
- Always run `git pull` before you start developing in local repo. This will sync
  local repo and remote repo.
