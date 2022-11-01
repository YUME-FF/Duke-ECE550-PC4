# ECE550-PC4

## Development Objective

### Opcode
| Instruction  | Opcode |
| ------------- | ------------- |
| R-type  | 00000  |
| Addi  | 00101  |
| Sw  | 00111  |
| Lw  | 01000  |
### Control Circuits
| Control Signal  | Decode |
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
