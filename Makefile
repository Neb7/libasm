#Sources
SRCS_DIR 	= srcs/

SRC			= ft_strlen.s \
			  ft_strcpy.s \
			  ft_strcmp.s \
			  ft_strdup.s \
			  ft_write.s \
			  ft_read.s


SRCS		= $(addprefix ${SRCS_DIR}, ${SRC})

#Bonus

SRC_BON_DIR	= bonus/

SRC_BON	= ft_atoi_base.s \
			  ft_list_push.s \
			  ft_list_remove_if.s \
			  ft_list_short.s \
			  ft_list_size.s

SRC_BONUS	= $(addprefix ${SRC_BON_DIR}, ${SRC_BON})

SRCS		+= $(addprefix ${SRCS_DIR}, ${SRC_BONUS})

#Object
OBJS_DIR	= .objects/
OBJS		= $(addprefix ${OBJS_DIR}, ${SRC:.s=.o})


ASM			= nasm

INCLUDES	= includes
EXEC		= test.out
NAME		= libasm.a
RM			= rm -f
CFLAGS		= -Wall -Wextra -Werror -I ${INCLUDES} -g3 -O3
DEBUG		= -fsanitize=address -g3
CC			= cc

#Colors
LIGHT_GRAY	= \033[2m
ORANGE		= \033[1;33m
DARK_GRAY	= \033[0;90m
RED			= \033[0;91m
GREEN		= \033[0;92m
YELLOW		= \033[0;93m
BLUE		= \033[0;94m
MAGENTA		= \033[0;95m
CYAN		= \033[0;96m
WHITE		= \033[0;97m
RESET		= \033[0m

#Forme
BOLD		= \033[1m
ITALIC		= \033[3m
UNDERLINE	= \033[4m
CROSS		= \033[9m
FLASH		= \033[5m
NEGATIF		= \033[7m

all:			${NAME}

${OBJS_DIR}%.o: ${SRCS_DIR}%.s
				@mkdir -p $(dir $@)
				@${ASM} -f elf64 $< -o $@

${OBJS_DIR}%.o: ${SRCS_DIR}%.c
				@mkdir -p $(dir $@)
				@${CC} ${CFLAGS} -c $< -o $@

${NAME}:		${OBJS_DIR} | ${OBJS}
				@ar rcs $@ ${OBJS}
				@echo "${YELLOW}'$@' is compiled ! ✅${RESET}"

${OBJS_DIR}:
				@mkdir -p ${OBJS_DIR}

test:			${NAME}
				@${CC} ${CFLAGS} -c ${SRCS_DIR}main.c -o ${OBJS_DIR}main.o
				@${CC} ${CFLAGS} ${OBJS_DIR}main.o -L. -lasm -o ${EXEC}
				@./${EXEC}


clean:
				@${RM} ${OBJS}
				@${RM} -r ${OBJS_DIR}
				@echo "${RED}'${NAME}' objects are deleted ! 👍${RESET}"

fclean:			clean
				@${RM} ${NAME} ${EXEC}
				@echo "${RED}'${NAME}' is deleted ! 👍${RESET}"

re:			fclean all

.PHONY:			all clean fclean re

