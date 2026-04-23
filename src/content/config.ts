import { defineCollection, z } from 'astro:content';

const projectsCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    cover: z.string(),
    order: z.number().default(99),
    date: z.coerce.date(),
    tags: z.array(z.string()).default([]),
  }),
});

const articlesCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    date: z.coerce.date(),
    tags: z.array(z.string()).default([]),
    summary: z.string().optional(),
  }),
});

const roadmapCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    status: z.enum(['规划中', '进行中', '已完成']).default('规划中'),
    date: z.coerce.date(),
    related_project: z.string().optional(),
  }),
});

export const collections = {
  projects: projectsCollection,
  articles: articlesCollection,
  roadmap: roadmapCollection,
};
