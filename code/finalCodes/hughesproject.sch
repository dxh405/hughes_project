<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <pattern><!-- jkc: fixing the white space issues that would cause the words to not output properly when <format> is used -->
        <rule context="format"> 
            <assert test="starts-with(., ' ')">
                Make sure this starts with a whitespace to make the text come out properly
            </assert>
        </rule>
        <rule context="line">
            <assert test="starts-with(., ' ')">
                Start with a whitespace to make everything match
            </assert>
        </rule>
    </pattern>
    <pattern> <!-- jkc: checking if the format tag is wrapping around the elements -->
        <rule context="format">
            <report test="ends-with(.,' ')">
                There should be text here.
            </report>
        </rule>
    </pattern>
    <pattern> <!-- jkc: Checking for distinct id tags -->
        <rule context="a">
            <report test="distinct-values(@href)">
                The links tags should be distinct. 
            </report>
        </rule>
        <rule context="h2">
            <report test="distinct-values(@id)">
                The id tags should be distinct. 
            </report>
        </rule>
    </pattern>
</schema>