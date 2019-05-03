FROM perl

RUN cpanm Devel::REPL
RUN cpanm Modern::Perl
RUN cpanm Data::Printer
RUN cpanm --notest Term::ReadLine::Gnu

RUN mkdir .re.pl \
    && echo 'use Modern::Perl;' > .re.pl/repl.rc \
    && echo 'use Data::Printer;' >> .re.pl/repl.rc

ENTRYPOINT ["re.pl"]
CMD ["--profile", "Standard"]
