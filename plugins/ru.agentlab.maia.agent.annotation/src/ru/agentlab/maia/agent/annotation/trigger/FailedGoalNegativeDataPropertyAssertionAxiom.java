package ru.agentlab.maia.agent.annotation.trigger;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.agent.annotation.converter.OWLDataPropertyAssertionAxiomTemplateConverter;
import ru.agentlab.maia.agent.event.FailedGoalNegativeDataPropertyAssertionAxiomEvent;
import ru.agentlab.maia.converter.PlanEventFilterConverter;
import ru.agentlab.maia.converter.PlanEventType;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@PlanEventType(FailedGoalNegativeDataPropertyAssertionAxiomEvent.class)
@PlanEventFilterConverter(OWLDataPropertyAssertionAxiomTemplateConverter.class)
public @interface FailedGoalNegativeDataPropertyAssertionAxiom {

	String[] value() default { "?$1", "?$2", "?$3" };

}
