const Joi = require('joi');

const eventSchema = Joi.object({
    title: Joi.string().required(),
    start: Joi.date().iso().required(),
    end: Joi.date().iso().greater(Joi.ref('start')).required(),
    description: Joi.string().required(),
    icon: Joi.string().required(),
    iconcolor: Joi.string().required(),
});


const noteSchema = Joi.object({
    key: Joi.string().required(),
    title: Joi.string().required(),
    text: Joi.string().required(),
    x: Joi.number().required(),
    y: Joi.number().required(),
    w: Joi.number().required(),
    h: Joi.number().required(),
  });

module.exports ={
    eventSchema,
    noteSchema
};