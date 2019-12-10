
import os

DATA_DIR="../../tests/test-data" #"../../tests/test-data/"

rule test_infernal:
    input: os.path.join(DATA_DIR,"tr-infernal-tblout.txt")

rule infernal_cmpress:
    input:
        os.path.join(DATA_DIR, "test-covariance-model.cm")
    output:
        os.path.join(DATA_DIR,"test-covariance-model.cm.i1i"),
        os.path.join(DATA_DIR,"test-covariance-model.cm.i1f"),
        os.path.join(DATA_DIR,"test-covariance-model.cm.i1m"),
        os.path.join(DATA_DIR,"test-covariance-model.cm.i1p")
    log:
        "logs/cmpress.log"
    params:
        extra = "",
    conda: "environment.yml"
    script: "cmpress.wrapper.py"

rule cmscan_profile:
    input:
        fasta=  os.path.join(DATA_DIR,"test-transcript.fa"),
        profile= os.path.join(DATA_DIR,"test-covariance-model.cm.i1i")
    output:
        tblout = os.path.join(DATA_DIR,"tr-infernal-tblout.txt"),
    log:
        "logs/cmscan.log"
    params:
        extra = "",
    threads: 4
    conda: "environment.yml"
    script: "cmscan.wrapper.py"
