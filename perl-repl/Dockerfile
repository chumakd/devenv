FROM perl

RUN cpanm Devel::REPL \
    && cpanm Modern::Perl \
    && cpanm Data::Printer \
    && cpanm --notest Term::ReadLine::Gnu

RUN mkdir .re.pl \
    && echo 'use Modern::Perl;' > .re.pl/repl.rc \
    && echo 'use Data::Printer;' >> .re.pl/repl.rc

ENTRYPOINT ["re.pl"]
CMD ["--profile", "Standard"]
