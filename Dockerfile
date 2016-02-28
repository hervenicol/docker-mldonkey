FROM scratch

ADD distrib /

EXPOSE 4000 4080 19040 19044

ENTRYPOINT mlnet.static
CMD -run_as_useruid 1001
