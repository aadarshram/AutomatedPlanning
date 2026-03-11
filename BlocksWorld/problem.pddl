;; This is the template for problem files for the 4-action blocks world model.
;;!pre-parsing:{type: "nunjucks", data: "p.json"} ; parse problem data from given JSON file

; Template problem definition 

(define (problem {{data.name}}) ;  problem name
(:domain blocksworld)

(:objects ; dynamically parse and format list of objects
{% if data.blocks|length > 0 %}
	{{ data.blocks|join(' ')}} - block
{% endif %}
)

{% macro output_state(state) %} ; macro- reusable code block to output state description in PDDL format
	{% for tower in state.towers %}
		{% for block in tower %}
			{% if loop.first %}(ontable {{block}})
			{% else %}(on {{block}} {{tower[loop.index0 - 1]}})
			{% endif %}
			{% if loop.last %}(clear {{block}}){% endif %}
		{% endfor %}
	{% endfor %}

	{% if state.hand %}
	; Hand
		{% if state.hand.empty %}
			(handempty)
		{% endif %}
		{% if state.hand.holding %}
			(holding {{state.hand.holding}})
		{% endif %}
	{% endif %}
{% endmacro %}

(:init
{{output_state(data.init)}}
)

(:goal (and 
{{output_state(data.goal)}}
))
)