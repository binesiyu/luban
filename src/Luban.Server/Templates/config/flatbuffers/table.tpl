{{~
    name = x.name
    key_type = x.key_ttype
    value_type =  x.value_ttype
    t = x.value_ttype.bean
~}}

table {{t.flat_buffers_full_name}} {
    {{~for f in t.hierarchy_export_fields ~}}
    {{~if x.is_map_table || x.is_list_table~}}
        {{~if x.index_field == f~}}
    {{f.name}}:{{flat_buffers_define_type f.ctype}}(key);
        {{~else~}}
    {{f.name}}:{{flat_buffers_define_type f.ctype}}{{flat_buffers_type_metadata f.ctype}};
        {{~end~}}
    {{~else~}}
    {{f.name}}:{{flat_buffers_define_type f.ctype}}{{flat_buffers_type_metadata f.ctype}};
    {{~end~}}
    {{~end~}}
}

table {{x.flat_buffers_full_name}} {
    // WARN! The name 'data_list' is used by FlatBuffersJsonExporter. don't modify it!
    {{~if x.is_singleton_table ~}}
    data_list:{{flat_buffers_define_type value_type}};
    {{~else~}}
    data_list:[{{flat_buffers_define_type value_type}}](required);
    {{~end~}}
}

root_type {{x.flat_buffers_full_name}};
