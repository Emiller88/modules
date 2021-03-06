#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { PICARD_MERGESAMFILES } from '../../../software/picard/mergesamfiles/main.nf' addParams( options: [:] )
include { PICARD_COLLECTMULTIPLEMETRICS } from '../../../software/picard/collectmultiplemetrics/main.nf' addParams( options: [:] )
include { PICARD_MARKDUPLICATES } from '../../../software/picard/markduplicates/main.nf' addParams( options: [:] )

workflow test_picard_mergesamfiles {

    def input = []
    input = [ [ id:'test', single_end:false ], // meta map
              [ file("${launchDir}/tests/data/bam/test.paired_end.sorted.bam", checkIfExists: true),
                file("${launchDir}/tests/data/bam/test.paired_end.name.sorted.bam", checkIfExists: true), ] ]

    PICARD_MERGESAMFILES ( input )
}


workflow test_picard_collectmultiplemetrics {

    def input = []
    input = [ [ id:'test', single_end:false ], // meta map
              file("${launchDir}/tests/data/bam/test.paired_end.name.sorted.bam", checkIfExists: true) ]

    PICARD_COLLECTMULTIPLEMETRICS (
        input,
        file("${launchDir}/tests/data/fasta/E_coli/NC_010473.fa", checkIfExists: true)
    )
}

workflow test_picard_markduplicates  {

    def input = []
    input = [ [ id:'test', single_end:false ], // meta map
              file("${launchDir}/tests/data/bam/test.paired_end.sorted.bam", checkIfExists: true) ]

    PICARD_MARKDUPLICATES ( input )
}

workflow test_picard_markduplicates_not_sorted  {

    def input = []
    input = [ [ id:'test', single_end:false ], // meta map
              file("${launchDir}/tests/data/bam/test.paired_end.name.sorted.bam", checkIfExists: true) ]

    PICARD_MARKDUPLICATES ( input )
}
