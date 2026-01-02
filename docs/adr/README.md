# Architecture Decision Records (ADR)

This directory contains Architecture Decision Records for the nix-darwin configuration. ADRs document important architectural decisions, their context, and consequences.

## What is an ADR?

An Architecture Decision Record captures a single architectural decision and its rationale. Each ADR describes:
- **Status**: Current state (Proposed, Accepted, Deprecated, Superseded)
- **Context**: The situation requiring a decision
- **Decision**: The chosen approach
- **Consequences**: Positive and negative outcomes

## Quick Reference

| ADR | Title | Status | Summary |
|-----|-------|--------|---------|
| [0001](0001-module-organization.md) | Module Organization Principles | Accepted | Hierarchical, domain-driven structure for nix modules |
| [0002](0002-separation-of-concerns.md) | Separation of Concerns | Accepted | Guidelines for darwin vs home-manager split |
| [0003](0003-dependency-management.md) | Dependency Management Strategy | Accepted | Flake inputs, overlays, and version management |
| [0004](0004-configuration-patterns.md) | Configuration Patterns | Accepted | Nix expression best practices and coding standards |

## When to Write an ADR

Create a new ADR when making decisions about:
- System architecture or organization
- Technology choices (overlays, modules, tools)
- Coding standards and patterns
- Build and deployment strategies
- Security or performance trade-offs

## How to Use These ADRs

### For Maintainers

Before making changes:
1. Review relevant ADRs to understand current decisions
2. Follow established patterns and principles
3. If your change conflicts with an ADR, either:
   - Adjust your approach to align with the ADR, or
   - Propose superseding the ADR with a new one

### For Contributors

When contributing:
1. Read ADRs related to your area of work
2. Follow the patterns and principles described
3. Ask questions if ADRs conflict or are unclear
4. Propose new ADRs for significant architectural changes

### For Understanding the System

To understand why the configuration is structured a certain way:
1. Start with [ADR 0001](0001-module-organization.md) for overall structure
2. Read [ADR 0002](0002-separation-of-concerns.md) for darwin vs home-manager
3. Check [ADR 0003](0003-dependency-management.md) for dependency choices
4. Review [ADR 0004](0004-configuration-patterns.md) for code patterns

## ADR Index by Topic

### System Architecture
- [0001: Module Organization Principles](0001-module-organization.md)
- [0002: Separation of Concerns - Darwin vs Home-Manager](0002-separation-of-concerns.md)

### Dependencies and Packages
- [0003: Dependency Management Strategy](0003-dependency-management.md)

### Code Quality
- [0004: Configuration Patterns and Best Practices](0004-configuration-patterns.md)

## Creating a New ADR

When creating a new ADR:

1. **Number sequentially**: Use the next available number (0005, 0006, etc.)
2. **Use the template**:
   ```markdown
   # ADR XXXX: [Title]

   ## Status
   [Proposed | Accepted | Deprecated | Superseded by ADR-YYYY]

   ## Context
   [What is the issue we're facing? What factors are relevant?]

   ## Decision
   [What is our decision? What approach are we taking?]

   ## Consequences
   ### Positive
   [What becomes easier or better?]

   ### Negative
   [What becomes harder or worse?]

   ## References
   [Links, related ADRs, documentation]
   ```

3. **Be specific**: Include code examples and file references
4. **Explain why**: Focus on rationale, not just what was decided
5. **Update this README**: Add the new ADR to the index tables

## ADR Status Lifecycle

- **Proposed**: Under discussion, not yet implemented
- **Accepted**: Agreed upon and actively guiding development
- **Deprecated**: No longer followed, but kept for historical context
- **Superseded**: Replaced by a newer ADR (reference the new one)

## Questions or Feedback

If you have questions about these ADRs or want to propose changes:
- Open an issue in the repository
- Propose a new ADR to supersede an existing one
- Ask for clarification in code reviews

## References

- [ADR Pattern and Practice](https://adr.github.io/)
- [Nix-Darwin Documentation](https://github.com/LnL7/nix-darwin)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- Project repository: `/Users/kazukishinohara/github/claude/nix-darwin`
