FROM ubuntu:xenial

RUN apt-get update -y && \
    apt-get install -y tesseract-ocr unpaper exactimage imagemagick poppler-utils ghostscript curl

RUN curl https://razaoinfo.dl.sourceforge.net/project/pdfsandwich/pdfsandwich%200.1.7/pdfsandwich_0.1.7_amd64.deb -o /tmp/pdfsandwich.deb

RUN cd /tmp && \
    dpkg -i pdfsandwich.deb && \
    apt-get -fy install

# https://stackoverflow.com/questions/42928765/convertnot-authorized-aaaa-error-constitute-c-readimage-453
COPY ./im_policy.xml /etc/ImageMagick-6/policy.xml

WORKDIR /root

CMD ['/usr/bin/pdfsandwich', '-nthreads', '1']
