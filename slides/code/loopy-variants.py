knl = ...

def variant_cpu(knl):
    knl = lp.split_dimension(knl, "i", 16*4096, outer_tag="g.0", slabs=(0, 1))
    knl = lp.split_dimension(knl, "i_inner", 16,
            inner_tag="unr")
    return knl

def variant_gpu(knl):
    knl = lp.split_dimension(knl, "i", 4*256, outer_tag="g.0", slabs=(0, 1))
    knl = lp.split_dimension(knl, "i_inner", block_size,
            outer_tag="unr", inner_tag="l.0")
    return knl

for variant in [variant_cpu, variant_gpu]:
    kernel_gen = lp.generate_loop_schedules(variant(knl))
    # ...
