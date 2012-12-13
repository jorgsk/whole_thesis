NAME=main_tome
CLEAN_FILES = *.log *.aux *.toc *.bbl *.blg ${NAME}.pdf *.xml *.bcf

RM = rm -f

default : pdf

$(NAME).pdf : $(NAME).tex
	xelatex -shell-escape $(NAME)
	@if(grep "There were undefined references" $(NAME).log > /dev/null);\
	then \
		biber $(NAME); \
		xelatex -shell-escape $(NAME); \
	fi
	
	@if(grep "Rerun" $(NAME).log > /dev/null);\
	then \
		 xelatex -shell-escape $(NAME);\
	fi
	# rm -f $(NAME).log

pdf : $(NAME).pdf

fast :
	xelatex -shell-escape $(NAME)

.PHONY : clean
clean :
	$(RM) ${CLEAN_FILES}

